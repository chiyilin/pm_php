<?php
/**
 * Created by Sublime Text3.
 * User: MuZone3
 * Date: 2018/9/25
 * Time: 10:13
 */

namespace app\admin\controller;

use think\Config;
use think\Image;
use app\common\model\ArticleCate as ArticleCateModel;


use app\common\model\Article as ArticleModel;

class Article extends Auth
{
    /**
     * 文章列表
     */
    public function index()
    {
        $config = Config::get('admin');
        $where = $search = [];
        if (input('param.article_cate')) {
            $where['article_cate'] = input('param.article_cate');
            $search['article_cate'] = input('param.article_cate');
        }
        $data = ArticleModel::where($where)->order('article_time desc')->paginate(Config::get('admin')['paginate']);
        $article_cate = ArticleCateModel::select();
//        dump($article_cate);
        // dump($data->toArray());
        return $this->fetch('', [
            'data' => $data,
            'search' => $search,
            'article_cate' => $article_cate,
        ]);
    }

    /**
     * 文章发表
     */
    public function add()
    {
        if (request()->isPost()) {
            // dump(input('param.article_details/a'));
//            $details = [];
//            foreach (input('param.article_details/a') as $key => $value) {
//                if (check_url($value)) {
//                    $details[]['image'] = $value;
//                } else {
//                    $details[]['text'] = $value;
//                }
//            }
            $res = ArticleModel::create([
                'article_title' => input('param.article_title'),
                'article_cate' => input('param.article_cate'),
                'article_cover' => input('param.article_cover'),
                'article_details' => htmlspecialchars_decode(input('param.article_details')) ,
                'article_time' => time(),
            ]);
            if ($res) {
                return $this->result($res, 200, '添加成功');
            } else {
                return $this->result($res, 200, '添加失败');
            }
        }
        $ArticleCateModel = ArticleCateModel::select();
        return $this->fetch('', ['ArticleCateModel' => $ArticleCateModel]);
    }

    /**
     * 图片上传
     */
    public function SynUpload()
    {
        $file = request()->file('file');
        if (!$file) {
            return $this->fetch();
        }
        $path = 'uploads/articleCover';
        $info = $file->move($path);
        $resImageInfo = $path . '/' . $info->getSaveName();
        $image = Image::open($resImageInfo);
        $image->thumb(500, 500)->save($resImageInfo);
        if ($info) {
            return $this->result($resImageInfo, 200, '成功');
        } else {
            return $this->result($file->getError(), 400, '失败');
        }
    }

    /**
     * 文章修改
     */
    public function edit()
    {
        if (request()->isPost()) {
            // dump(input('param.article_details/a'));
//            $details = [];
//            foreach (input('param.article_details/a') as $key => $value) {
//                if (check_url($value)) {
//                    $details[]['image'] = $value;
//                } else {
//                    $details[]['text'] = $value;
//                }
//            }
            $res = ArticleModel::update([
                'article_title' => input('param.article_title'),
                'article_cover' => input('param.article_cover'),
                'article_cate' => input('param.article_cate'),
                'article_details' => htmlspecialchars_decode(input('param.article_details')) ,
            ], ['article_id' => input('param.article_id')]);
            if ($res) {
                return $this->result($res, 200, '修改成功');
            } else {
                return $this->result($res, 200, '修改失败');
            }
        }

        $ArticleCateModel = ArticleCateModel::select();
        $details = ArticleModel::find(input('param.id'));
        return $this->fetch('', [
            'details' => $details,
            'ArticleCateModel' => $ArticleCateModel
        ]);
    }
    /**
     * wangEditor 上传图片
     */
    public function imageUpload()
    {
        // 获取表单上传文件
        $files = request()->file('file');
        $path = 'uploads/articleImg';
        $url = [];
        foreach ($files as $file) {
            $info = $file->move($path);
            $resImageInfo = $path . '/' . $info->getSaveName();
            $image = Image::open($resImageInfo);
            $image->thumb(1080, 1080)->save($resImageInfo);
            if ($info) {
                $url[] = getHttpHost() . '/' . $resImageInfo;
            }
        }
        $result = [
            'errno' => 0,
            'data' => $url,
        ];
        echo json_encode($result);
    }
    /**
     * 上传图片
     */
//    public function imageUpload()
//    {
//        $file = request()->file('file');
//        $path = 'uploads/articleImg';
//        $info = $file->move($path);
//        $resImageInfo = $path . '/' . $info->getSaveName();
//        $image = \think\Image::open($resImageInfo);
//        $image->thumb(1080, 1080)->save($resImageInfo);
//        if ($info) {
//            $url = getHttpHost() . '/' . $resImageInfo;
//            echo json_encode(['result' => 'ok', 'url' => $url, 'message' => 'success']);
//        }
//    }

    /**
     * 单删
     */
    public function del()
    {
        $result = ArticleModel::destroy(input('param.id'));
        return $msg = $result ? '删除成功' : '删除失败';
    }

    /**
     * 多删
     */
    public function delall()
    {
        $id = input('param.id/a');
        if (empty($id)) return '请选中后操作！';

        $idArr = implode(',', $id);
        $result = ArticleModel::destroy($idArr);
        return $msg = $result ? json_encode([200, '删除成功']) : json_encode([400, '删除失败']);
    }
}