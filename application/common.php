<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------
use app\common\model\UserMessage;
use app\common\model\ConfigFx;
use app\common\model\User;


// 应用公共文件

//生成订单号
function order_number($user_id = null, $id = null)
{
//    return date('Ymd', time()) . time() . rand(10, 99);//18位
//    return md5($openid . time() . rand(10, 99));//32位
    return substr(time(), -5) . rand(100, 999) . $user_id . rand(100, 999) . $id;
}

//正确的url
function check_url($url)
{

    if (!preg_match('/https:\/\/[\w.]+[\w\/]*[\w.]*\??[\w=&\+\%]*/is', $url)) {

        return false;

    }

    return true;

}

/*
 * 返回域名信息
 * */
function getHttpHost()
{
    $http_type = ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') || (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')) ? 'https://' : 'http://';
    return $http_type . $_SERVER['HTTP_HOST'];
}

/**
 * [array_group_by ph]
 * @param  [type] $arr [二维数组]
 * @param  [type] $key [键名]
 * @return [type]      [新的二维数组]
 */
function array_group_by($arr, $key)
{
    $grouped = array();
    foreach ($arr as $value) {
        $grouped[$value[$key]][] = $value;
    }
    if (func_num_args() > 2) {
        $args = func_get_args();
        foreach ($grouped as $key => $value) {
            $parms = array_merge($value, array_slice($args, 2, func_num_args()));
            $grouped[$key] = call_user_func_array('array_group_by', $parms);
        }
    }
    return $grouped;
}

//验证身份证是否有效
function validateIDCard($IDCard)
{
    if (strlen($IDCard) == 18) {
        return check18IDCard($IDCard);
    } elseif ((strlen($IDCard) == 15)) {
        $IDCard = convertIDCard15to18($IDCard);
        return check18IDCard($IDCard);
    } else {
        return false;
    }
}

//计算身份证的最后一位验证码,根据国家标准GB 11643-1999
function calcIDCardCode($IDCardBody)
{
    if (strlen($IDCardBody) != 17) {
        return false;
    }

    //加权因子
    $factor = array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
    //校验码对应值
    $code = array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
    $checksum = 0;

    for ($i = 0; $i < strlen($IDCardBody); $i++) {
        $checksum += substr($IDCardBody, $i, 1) * $factor[$i];
    }

    return $code[$checksum % 11];
}

// 将15位身份证升级到18位
function convertIDCard15to18($IDCard)
{
    if (strlen($IDCard) != 15) {
        return false;
    } else {
        // 如果身份证顺序码是996 997 998 999，这些是为百岁以上老人的特殊编码
        if (array_search(substr($IDCard, 12, 3), array('996', '997', '998', '999')) !== false) {
            $IDCard = substr($IDCard, 0, 6) . '18' . substr($IDCard, 6, 9);
        } else {
            $IDCard = substr($IDCard, 0, 6) . '19' . substr($IDCard, 6, 9);
        }
    }
    $IDCard = $IDCard . calcIDCardCode($IDCard);
    return $IDCard;
}

// 18位身份证校验码有效性检查
function check18IDCard($IDCard)
{
    if (strlen($IDCard) != 18) {
        return false;
    }

    $IDCardBody = substr($IDCard, 0, 17); //身份证主体
    $IDCardCode = strtoupper(substr($IDCard, 17, 1)); //身份证最后一位的验证码

    if (calcIDCardCode($IDCardBody) != $IDCardCode) {
        return false;
    } else {
        return true;
    }
}

/**
 * 分销算法
 */
function Gift($user_id, $payMoney)
{
//    a:2:{i:0;s:3:"259";i:1;s:3:"257";}
    $userInfo = User::find($user_id);
//        dump('下级消费'.$payMoney);
    if (empty($userInfo['fid_chain'])) {
        return '暂无上级';
    }
    $fidChainArr = array_slice(unserialize($userInfo['fid_chain']), -2);
    $fidChainCount = count($fidChainArr);
    $config = ConfigFx::find()->toArray();
    $config['fxs'] = json_decode($config['fxs'], true);
    $messageData = [];
    foreach ($fidChainArr as $key => $value) {
//            dump('第'.($key+1).'次');
        $temUserInfo = User::find($value);
        if (!empty($temUserInfo)) {
            $messageData[$key] = [
                'user_id' => $value,
                'message_title' => '获得一个红包！',
                'message_content' => '请及时查看！！',
                'message_add_time' => time(),
            ];
            $temFxData = $config['fxs'][$temUserInfo['fxs_level']];
            $times = $fidChainCount > 1 && $key == 0 ? $temFxData['two'] : $temFxData['one'];
            $timesMoney = $payMoney * $times * 0.01;
//                dump('未扣随机数前'.$timesMoney);
            $basicMoney = ($timesMoney) - rand(0, $timesMoney);
//                dump('随机数后'.$basicMoney);

            if (mt_rand(1, 100) <= $config['probability']) {
                //获得现金
                $messageData[$key]['message_type'] = 2;
                $messageData[$key]['money'] = $basicMoney * $config['money_times'];
            } else {
                //获得积分
                $messageData[$key]['message_type'] = 3;
                $messageData[$key]['money'] = $basicMoney * $config['integral_times'];
            }

        }
    }
    if (!empty($messageData)) {
        $UserMessage = new UserMessage();
        $UserMessage->saveAll($messageData);
    }
}
