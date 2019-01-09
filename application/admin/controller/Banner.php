<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/19
 * Time: 13:32
 */

namespace app\admin\controller;

use think\Config;
use app\common\model\Banner as BannerModel;
use think\helper\Str;

class Banner extends Auth
{
    /**
     *
     */
    public function page()
    {
        $page = Config::get('page');
        if (request()->isGet()) {
            if (input('param.id')) {
                $bannerInfo = BannerModel::find(input('param.id'));
//                dump($bannerInfo['path_index']);
                if (!empty($bannerInfo['path_index'])) {
                    $this->assign('ext', $bannerInfo['path_index']);
                    if($bannerInfo['path_index']==input('param.index')){
                        $this->assign('extInfo', unserialize($bannerInfo['ext']));
                    }else{
                        $this->assign('extInfo', null);
                    }
                }else{
                    $this->assign('extInfo', null);
                }
                $this->assign('banner_id', input('param.id'));
            }
            if (input('param.index')||input('param.index')==0) {
                $this->assign('ext', input('param.index'));
            }
        }
        if (request()->isPost()) {
            $data = request()->post()['data'];
            $pathInfo = $page[$data['page']];

            $updateData=[
                'ext' => null,
                'path_index' => $data['page'],
                'path' => $pathInfo['addr'],
            ];

            if(!empty(request()->post()['details'])){
                $updateData['ext']=serialize(request()->post()['details']);
            }
//            $extStr='';
//            foreach ($pathInfo['ext'] as $key=>$value){
//                if($key==0){
//                    $extStr.='?';
//                }else{
//                    $extStr.='&';
//                }
//                $extStr.=$value.'='.$ext[$key];
//            }
            $res=BannerModel::where('banner_id', $data['banner_id'])->update($updateData);
            return $res ? json_encode([200, '操作成功！']) : json_encode([400, '操作失败！']);
//            $this->assign('ext',input('param.index'));
        }

        $this->assign('page', $page);
//        dump($page);
        return $this->fetch();
    }

    /**
     * Banner 首页
     */
    public function index()
    {
        $config = Config::get('admin');
        $page = Config::get('page');
        // dump($config);
        return $this->fetch('', [
            'page'=>$page,
            'data' => BannerModel::order('sort')->paginate($config['paginate']),
        ]);
    }

    /**
     * Banner 上传（异步）
     */
    public function SynUpload()
    {
        $file = request()->file('file');
        if (!$file) {
            return $this->fetch();
        }
        $path = 'uploads/banner';
        $info = $file->move($path);

        $resImageInfo = $path . '/' . $info->getSaveName();
        $image = \think\Image::open($resImageInfo);
        $image->thumb(1080, 1080)->save($resImageInfo);


        if ($info) {
            $Banner = new BannerModel();
            $Banner->data([
                'url' => $resImageInfo,
                'add_time' => time(),
            ]);
            if ($Banner->save()) {
                return $this->result($resImageInfo, 200, '成功');
            }
        } else {
            return $this->result($file->getError(), 400, '失败');
        }
    }

    /**
     * 修改banner状态
     */
    public function editstatus()
    {
        $param = input('param.');
        $BannerModel = new BannerModel();
        $result = $BannerModel->save(
            [
                'display' => $param['value']
            ], [
                'banner_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    /**
     * 修改banner排序
     */
    public function editsort()
    {
        $param = input('param.');
        $BannerModel = new BannerModel();
        $result = $BannerModel->save(
            [
                'sort' => $param['value']
            ], [
                'banner_id' => $param['id']
            ]
        );
        return $result ? json_encode([200, '修改成功！']) : json_encode([400, '修改失败！']);
    }

    //删除
    public function del()
    {
        $id = input('param.id');
        $Banner = BannerModel::get($id);
        $url = ROOT_PATH . $Banner->url;
        if (file_exists($url)) {
            unlink($url);
            clearstatcache();
        }
        $result = BannerModel::destroy($id);
        return $msg = $result ? '删除成功' : '删除失败';
    }

    //多选删除
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';
        $idArr = implode(',', $id);
        $bannerArr = BannerModel::where('banner_id', 'in', $idArr)->field('url')->select();
        foreach ($bannerArr as $key => $value) {
            $path = ROOT_PATH . $value['url'];
            if (file_exists($path)) {
                unlink($path);
                clearstatcache();
            }
        }
        $result = BannerModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}