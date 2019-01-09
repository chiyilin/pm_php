<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/19
 * Time: 12:02
 */

namespace app\api\controller;

use think\Controller;
use app\common\model\Banner;
use app\common\model\Article;
use app\common\model\Collection;
use app\common\model\Product;
use app\common\model\CrontabSetting;


use think\Config;

class Index extends Controller
{
    public function test()
    {
        call_user_func('app\command\Hour::Prod');
        die();
        $time = time();
        $exe_method = [];
        $crond_list = Config::get('crond');
        $data = CrontabSetting::where(['is_happen' => 1])->select();
        foreach ($data as $key => $value) {
            $setting = [
                $value['start_time'] => json_decode($value['controller'])
            ];
            $crond_list = array_merge($crond_list, $setting);
        }
        $sys_crond_timer = Config::get('sys_crond_timer');
        foreach ($sys_crond_timer as $format) {
            $key = date($format, ceil($time));
            if (is_array(@$crond_list[$key])) {
                $exe_method = array_merge($exe_method, $crond_list[$key]);
            }
        }
        if (!empty($exe_method)) {
            foreach ($exe_method as $method) {
                if (!is_callable($method)) {
                    //方法不存在的话就跳过不执行
                    echo '方法不存在';
                    continue;
                }
//                echo "crond --- {$method}()\n";
                $runtime_start = microtime(true);

                call_user_func($method);

                $runtime = microtime(true) - $runtime_start;

//                echo "{$method}(), times: {$runtime}\n\n";
            }

//            $time_total = microtime(true) - $GLOBALS['_beginTime'];
//            print_r($exe_method);
//            echo "total:{$time_total}\n";
        }


        $crond_list = Config::get('crond');
        $data = CrontabSetting::where(['is_happen' => 1])->select();
//        dump($data->toArray());
        foreach ($data as $key => $value) {
            $setting = [
                $value['start_time'] => json_decode($value['controller'])
            ];
            $crond_list = array_merge($crond_list, $setting);
        }
        echo date('Y-m-d H:i:s', strtotime('2018-12-16 14:00:05'));
        die();
        echo strtotime('2018-12-16 14:00:05');
        halt($crond_list[strtotime('2018-12-16 14:00:05')]);


        halt($crond_list);
        $str = json_encode(['app\command\Test::firstTest']);
        echo $str;

        die();
        echo date('*:i', time());
    }

    /**
     * 获取首页首页
     */
    public function index()
    {
        //获取首页Banner信息；
        $banner = Banner::where('display', 1)->order('sort desc')->select()->toArray();
        //专场
        $collection = Collection::where(['collection_status' => 1])->order(['collection_sort' => 'desc'])->limit(6)->select();
        //猜你喜欢
        $shareProd = Product::withCount(['userOfferPrice'])->where([
        ])->order([
            'product_sort' => 'desc',
            'product_time' => 'desc'
        ])->field('product_id,product_name,product_cover,cover_introduce,product_name')->select();
//        halt($shareProd->toArray());
        //公共文章
        $article = Article::field('article_title,article_id')->limit(5)->order(['article_time' => 'desc'])->select();
        $data = compact('banner', 'collection', 'shareProd', 'article');
        $this->result($data, 200, 'success');

    }

    /**
     * 首页选项卡切换二级分类
     */
    public function product()
    {
        $category_id = input('param.category_id');
        $index = input('param.index');
        $where = [];
        $where['product_status'] = 1;
        if ($category_id) {
            $where['product_category'] = $category_id;
        }
        //热门课程、推荐课程、最新课程
        if ($index == 0) {
            $sort = ['product_subscribe' => 'desc'];
        } else if ($index == 1) {
            $sort = ['product_sort' => 'asc'];
        } else {
            $sort = ['product_time' => 'desc'];
        }
        //halt($sort);
        $data = Product::where($where)->order($sort)->limit(3)->select()->toArray();
        foreach ($data as $key => $value) {
            $temArr = json_decode($value['product_introduce'], true);
            $temStr = '';
            if (!is_array($temArr)) continue;
            foreach ($temArr as $k => $v) {
                $temStr .= !empty($v['image']) ? ' [图片] ' : $v['text'];
            }
            $data[$key]['product_introduce'] = $temStr;
        }
        return $this->result($data, 200, '产品信息获取成功');
    }
}