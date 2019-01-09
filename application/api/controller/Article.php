<?php

namespace app\api\controller;

use app\common\model\Article as ArticleModel;
use app\common\model\ArticleCate;

use think\Controller;
use think\Request;

class Article extends Controller
{
    /**
     * @param Request $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function index(Request $request)
    {
        $param = $request->param();
        if (!empty($param['article_cate'])) {
            $article = ArticleModel::where('article_cate', $param['article_cate'])->select();
        } else {
            $article = ArticleModel::where([])->select();
        }
        for ($i = 0; $i < count($article); $i++) {
            $article[$i]['article_time'] = date('Y-m-d H:i', $article[$i]['article_time']);
        }
        $articleCate = ArticleCate::select()->toArray();
        array_unshift($articleCate, ['cate_name' => '全部']);
        $this->result(compact('article', 'articleCate'), 200, 'success');
    }

    /**
     * @param Request $request
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function details(Request $request)
    {
        $param = $request->param();
        $details = ArticleModel::get($param['id']);
        $details->article_time = date('Y-m-d H:i:s', $details->article_time);
        $this->result($details, 200, 'success');
    }
}