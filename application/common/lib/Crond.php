<?php
/**
 * Created by PhpStorm.
 * Date: 2016/10/17
 * Time: 16:27
 * User: 潘国兴
 * Email: denispan@outlook.com
 */

namespace app\common\lib;

header("Content-Type: text/html;charset=utf-8");

use think\Config;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use app\common\model\CrontabSetting;

class Crond extends Command
{
    protected function configure()
    {
        $this->setName('Cron')->setDescription('计划任务');
    }

    protected function execute(Input $input, Output $output)
    {
        $this->doCron();
//        $output->writeln("End!");
    }

    public function doCron()
    {
        // 记录开始运行的时间
        $GLOBALS['_beginTime'] = microtime(TRUE);
        /* 永不超时 */
        ini_set('max_execution_time', 0);
        $time = time();
        $exe_method = [];
        //获取第四步的文件配置，根据自己版本调整一下
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
                    continue;
                }
//                echo "crond --- {$method}()\n";
                $runtime_start = microtime(true);

                call_user_func($method);

                $runtime = microtime(true) - $runtime_start;

//                echo "{$method}(), times: {$runtime}\n\n";
            }

            $time_total = microtime(true) - $GLOBALS['_beginTime'];
//            print_r($exe_method);
//            echo "total:{$time_total}\n";
        }
    }
}