-- DDL


SET
FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for action
-- ----------------------------
DROP TABLE IF EXISTS `action`;
CREATE TABLE `action`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `action_type`  varchar(100) NOT NULL DEFAULT '' COMMENT '操作类型',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `pipeline_id`  bigint(20) unsigned NOT NULL COMMENT 'pipelineId',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `context`      mediumtext COMMENT '上下文内容json格式',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_pipeline` (`pipeline_id`),
    KEY            `idx_project` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dashboard
-- ----------------------------
DROP TABLE IF EXISTS `dashboard`;
CREATE TABLE `dashboard`
(
    `id`             bigint(20) NOT NULL AUTO_INCREMENT,
    `project_id`     bigint(20) unsigned NOT NULL COMMENT '项目id',
    `layout`         longtext COMMENT '看板布局',
    `publish_layout` longtext COMMENT '发布配置',
    `publish_time`   datetime          DEFAULT NULL COMMENT '发布时间',
    `status`         tinyint(4) DEFAULT '0' COMMENT '发布状态:0=未发布;1=已发布',
    `gmt_create`     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`   bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`    bigint(20) NOT NULL COMMENT '初始创建者',
    `publish_no`     varchar(100)      DEFAULT NULL COMMENT '发布号',
    `name`           varchar(255)      DEFAULT '画布1' COMMENT '名称',
    `type`           varchar(127)      DEFAULT '系统' COMMENT '类型',
    `is_complex`     tinyint(1) DEFAULT '0' COMMENT '是否包含复杂widget',
    `mapping_json`   text COMMENT '新旧taskId对应关系',
    `show_watermark` tinyint(1) DEFAULT '1' COMMENT '发布后是否有水印',
    PRIMARY KEY (`id`),
    UNIQUE KEY `publish_no` (`publish_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for data_level
-- ----------------------------
DROP TABLE IF EXISTS `data_level`;
CREATE TABLE `data_level`
(
    `id`           int(6) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`         varchar(255) NOT NULL COMMENT '数据中文名',
    `name_en`      varchar(255)          DEFAULT NULL COMMENT '数据英文名',
    `level`        varchar(255) NOT NULL COMMENT '数据分级（L1~L4）',
    `content`      varchar(1047)         DEFAULT NULL COMMENT '数据说明',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `gmt_modifier` bigint(8) DEFAULT NULL COMMENT '创建者',
    `gmt_creator`  bigint(8) DEFAULT NULL COMMENT '修改者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for database
-- ----------------------------
DROP TABLE IF EXISTS `database`;
CREATE TABLE `database`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) NOT NULL COMMENT '数据源名称',
    `type`         varchar(20)  NOT NULL COMMENT '数据源类型',
    `config_json`  text COMMENT '数据源配置',
    `description`  varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据源表';

-- ----------------------------
-- Table structure for dataset
-- ----------------------------
DROP TABLE IF EXISTS `dataset`;
CREATE TABLE `dataset`
(
    `id`                      bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`                    varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '名称',
    `user_id`                 bigint(20) unsigned NOT NULL COMMENT '所属用户id',
    `category_id`             bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '所属类别id',
    `data_json`               text COMMENT '数据集元信息',
    `data_config`             text COMMENT '数据源的配置信息',
    `incremental_data_config` text COMMENT '增量数据的详细配置',
    `description`             varchar(255)                                     NOT NULL DEFAULT '' COMMENT '描述',
    `gmt_create`              datetime                                         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`              datetime                                         NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`            bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`             bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_user_category_name` (`user_id`,`category_id`,`name`),
    KEY                       `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集表';

-- ----------------------------
-- Table structure for dataset_action
-- ----------------------------
DROP TABLE IF EXISTS `dataset_action`;
CREATE TABLE `dataset_action`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `action_type`  varchar(100) NOT NULL DEFAULT '' COMMENT '操作类型',
    `dataset_id`   bigint(20) unsigned NOT NULL COMMENT '数据集id',
    `row_affect`   bigint(20) unsigned NOT NULL COMMENT '影响行数',
    `row_final`    bigint(20) unsigned DEFAULT NULL COMMENT '最终行数',
    `context`      mediumtext COMMENT '具体操作',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `status`       varchar(100) NOT NULL DEFAULT '' COMMENT '用户是否已读',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '创建者',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '修改者',
    PRIMARY KEY (`id`),
    KEY            `idx_user` (`user_id`) USING BTREE,
    KEY            `idx_dataset` (`dataset_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for dataset_category
-- ----------------------------
DROP TABLE IF EXISTS `dataset_category`;
CREATE TABLE `dataset_category`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) NOT NULL COMMENT '数据集目录名称',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `parent_id`    bigint(20) unsigned DEFAULT NULL COMMENT '数据集目录父目录',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dataset_project
-- ----------------------------
DROP TABLE IF EXISTS `dataset_project`;
CREATE TABLE `dataset_project`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `project_id`   bigint(20) unsigned DEFAULT NULL COMMENT '项目id',
    `dataset_id`   bigint(20) unsigned NOT NULL COMMENT '数据集id',
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0' COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_dataset_project` (`dataset_id`,`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='数据集项目关联表';

-- ----------------------------
-- Table structure for external_data_source
-- ----------------------------
DROP TABLE IF EXISTS `external_data_source`;
CREATE TABLE `external_data_source`
(
    `id`           int(6) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `name`         varchar(255) NOT NULL COMMENT '外部数据名（统一风格：英文字母全部小写）',
    `content`      varchar(1047)         DEFAULT NULL COMMENT '说明',
    `type`         varchar(255)          DEFAULT NULL COMMENT '所属类别',
    `logo`         text                  DEFAULT NULL COMMENT 'logo图片',
    `status`       char(2)               DEFAULT '1' COMMENT '状态值：1：可用，0：不可用',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
    `gmt_modifier` bigint(8) DEFAULT NULL COMMENT '创建者',
    `gmt_creator`  bigint(8) DEFAULT NULL COMMENT '修改者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='外部数据源信息表';

-- ----------------------------
-- Table structure for folder
-- ----------------------------
DROP TABLE IF EXISTS `folder`;
CREATE TABLE `folder`
(
    `id`           int(11) NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) DEFAULT NULL,
    `user_id`      int(11) NOT NULL,
    `project_id`   int(11) NOT NULL DEFAULT '0',
    `model_info`   varchar(255) DEFAULT NULL,
    `unfold`       int(11) NOT NULL DEFAULT '0',
    `gmt_create`   datetime     DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`   datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_creator`  bigint(20) DEFAULT NULL,
    `gmt_modifier` bigint(20) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for formula_history
-- ----------------------------
DROP TABLE IF EXISTS `formula_history`;
CREATE TABLE `formula_history`
(
    `id`            bigint(20) NOT NULL AUTO_INCREMENT,
    `task_id`       bigint(20) NOT NULL COMMENT '实际表名',
    `name`          varchar(255) NOT NULL COMMENT '展示的表名',
    `formula`       varchar(255) DEFAULT NULL COMMENT '原始公式',
    `result`        varchar(255) DEFAULT NULL COMMENT '公式的结果',
    `project_id`    bigint(20) NOT NULL COMMENT '项目id',
    `type`          varchar(255) DEFAULT NULL,
    `table_name`    varchar(255) NOT NULL,
    `precision_num` tinyint(10) DEFAULT '1' COMMENT '数字类型结果精度',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for graph
-- ----------------------------
DROP TABLE IF EXISTS `graph`;
CREATE TABLE `graph`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
    `project_id`   bigint(20) unsigned NOT NULL,
    `pipeline_id`  bigint(20) unsigned DEFAULT NULL,
    `user_id`      bigint(20) unsigned NOT NULL,
    `task_id`      bigint(20) unsigned DEFAULT NULL,
    `data_json`    longtext CHARACTER SET utf8mb4,
    `gmt_create`   datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`   datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier` bigint(20) NOT NULL,
    `gmt_creator`  bigint(20) NOT NULL,
    PRIMARY KEY (`id`),
    KEY            `pipeline_id` (`pipeline_id`),
    KEY            `user_id` (`user_id`),
    KEY            `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for graph_action
-- ----------------------------
DROP TABLE IF EXISTS `graph_action`;
CREATE TABLE `graph_action`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `action_type`  varchar(100) NOT NULL DEFAULT '' COMMENT '操作类型',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `pipeline_id`  bigint(20) unsigned DEFAULT NULL COMMENT 'pipelineId',
    `task_id`      bigint(20) unsigned DEFAULT NULL COMMENT '任务节点id',
    `graph_id`     bigint(20) unsigned NOT NULL COMMENT '图构建id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `context`      mediumtext CHARACTER SET utf8mb4 COMMENT '上下文内容json格式',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`) USING BTREE,
    KEY            `idx_pipeline` (`pipeline_id`) USING BTREE,
    KEY            `idx_project` (`project_id`) USING BTREE,
    KEY            `idx_graph` (`graph_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for graph_filter
-- ----------------------------
DROP TABLE IF EXISTS `graph_filter`;
CREATE TABLE `graph_filter`
(
    `id`                       bigint(20) NOT NULL AUTO_INCREMENT COMMENT '过滤器id',
    `name`                     varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '过滤器名称',
    `project_id`               bigint(20) unsigned NOT NULL COMMENT '项目id',
    `graph_id`                 bigint(20) unsigned NOT NULL COMMENT '图视图id',
    `graph_filter_pipeline_id` bigint(20) unsigned NOT NULL COMMENT '过滤器流程图id',
    `type`                     tinyint(4) unsigned NOT NULL,
    `sub_type`                 tinyint(4) unsigned NOT NULL,
    `parent_id`                bigint(20) unsigned DEFAULT NULL COMMENT '父过滤器id',
    `user_id`                  bigint(20) unsigned NOT NULL COMMENT '用户id',
    `data_json`                longtext CHARACTER SET utf8mb4,
    `gmt_create`               datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`               datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier`             bigint(20) NOT NULL,
    `gmt_creator`              bigint(20) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY                        `graph_id` (`graph_id`) USING BTREE,
    KEY                        `graph_filter_pipeline_id` (`graph_filter_pipeline_id`) USING BTREE,
    KEY                        `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图分析过滤器表';

-- ----------------------------
-- Table structure for graph_filter_pipeline
-- ----------------------------
DROP TABLE IF EXISTS `graph_filter_pipeline`;
CREATE TABLE `graph_filter_pipeline`
(
    `id`           bigint(20) NOT NULL AUTO_INCREMENT COMMENT '过滤器流程id',
    `name`         varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '过滤器流程名称',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `graph_id`     bigint(20) unsigned NOT NULL COMMENT '图视图id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `data_json`    longtext CHARACTER SET utf8mb4,
    `gmt_create`   datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`   datetime                           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier` bigint(20) NOT NULL,
    `gmt_creator`  bigint(20) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY            `graph_id` (`graph_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图分析过滤器流程图表';

-- ----------------------------
-- Table structure for graph_filter_pipeline_instance
-- ----------------------------
DROP TABLE IF EXISTS `graph_filter_pipeline_instance`;
CREATE TABLE `graph_filter_pipeline_instance`
(
    `id`                       bigint(20) NOT NULL AUTO_INCREMENT COMMENT '过滤器流程id',
    `project_id`               bigint(20) unsigned NOT NULL COMMENT '项目id',
    `graph_id`                 bigint(20) unsigned NOT NULL COMMENT '图视图id',
    `graph_filter_pipeline_id` bigint(20) unsigned NOT NULL COMMENT '过滤器流程图id',
    `user_id`                  bigint(20) unsigned NOT NULL COMMENT '用户id',
    `data_json`                longtext CHARACTER SET utf8mb4,
    `status`                   char(10) NOT NULL DEFAULT 'CREATE' COMMENT '任务状态',
    `during_time`              bigint(20) DEFAULT '0' COMMENT '开始执行到结束耗时',
    `log_info`                 text CHARACTER SET utf8mb4 COMMENT '日志',
    `run_times`                int(10) DEFAULT '0' COMMENT '执行次数',
    `gmt_create`               datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`               datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_running`              datetime          DEFAULT NULL COMMENT '开始执行时间',
    `gmt_modifier`             bigint(20) NOT NULL,
    `gmt_creator`              bigint(20) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY                        `graph_id` (`graph_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='图分析过滤器流程运行实例';

-- ----------------------------
-- Table structure for graph_instance
-- ----------------------------
DROP TABLE IF EXISTS `graph_instance`;
CREATE TABLE `graph_instance`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `graph_id`     bigint(20) unsigned NOT NULL COMMENT '图id',
    `task_id`      bigint(20) unsigned DEFAULT NULL COMMENT '任务id',
    `pipeline_id`  bigint(20) unsigned DEFAULT NULL COMMENT 'pipelineId',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `data_json`    text CHARACTER SET utf8mb4 COMMENT 'json结果',
    `status`       char(10) NOT NULL DEFAULT 'CREATE' COMMENT '任务状态',
    `during_time`  bigint(20) DEFAULT '0' COMMENT '开始执行到结束耗时',
    `log_info`     text CHARACTER SET utf8mb4 COMMENT '日志',
    `run_times`    int(10) DEFAULT '0' COMMENT '执行次数',
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_running`  datetime          DEFAULT NULL COMMENT '开始执行时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_pipeline` (`pipeline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for jlab
-- ----------------------------
DROP TABLE IF EXISTS `jlab`;
CREATE TABLE `jlab`
(
    `id`      bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) DEFAULT NULL,
    `port`    bigint(20) DEFAULT NULL,
    `token`   varchar(100) DEFAULT NULL,
    `active`  int(11) DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `table_name_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for model
-- ----------------------------
DROP TABLE IF EXISTS `model`;
CREATE TABLE `model`
(
    `id`               bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`          bigint(20) NOT NULL,
    `project_id`       bigint(20) NOT NULL,
    `algorithm`        varchar(100) DEFAULT NULL COMMENT 'algorithm name',
    `model_type`       varchar(100) DEFAULT NULL,
    `name`             varchar(100) DEFAULT NULL COMMENT 'user define name',
    `model_desc`       text COMMENT 'model description',
    `param`            text,
    `source_table`     varchar(100) DEFAULT NULL,
    `source_id`        bigint(20) DEFAULT NULL,
    `source_name`      varchar(255) DEFAULT NULL,
    `model_saved_path` text,
    `other_info`       longtext COMMENT 'metrics & result',
    `status`           varchar(100) DEFAULT NULL,
    `in_panel`         bigint(1) unsigned zerofill DEFAULT '0' COMMENT '1 for models in panel(not in folder); 2 for models in folder',
    `folder_id`        bigint(20) DEFAULT NULL,
    `algotime`         float        DEFAULT NULL,
    `sparktime`        float        DEFAULT NULL,
    `runtime`          float        DEFAULT NULL COMMENT 'algo runtime',
    `num`              bigint(20) DEFAULT NULL COMMENT 'data source num row',
    `progress_id`      varchar(100) DEFAULT NULL COMMENT 'PID/applicaiton ID to kill',
    `gmt_creator`      bigint(20) DEFAULT NULL,
    `gmt_create`       datetime     DEFAULT CURRENT_TIMESTAMP,
    `gmt_modifier`     bigint(20) DEFAULT NULL,
    `gmt_modify`       datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `invisible`        tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 for model in panel but not in the list',
    `train_time`       datetime     DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `model_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for model_instance
-- ----------------------------
DROP TABLE IF EXISTS `model_instance`;
CREATE TABLE `model_instance`
(
    `id`               bigint(20) DEFAULT NULL,
    `user_id`          bigint(20) DEFAULT NULL,
    `algorithm`        varchar(100) DEFAULT NULL COMMENT 'algorithm name',
    `model_desc`       text COMMENT 'model description',
    `source_table`     varchar(100) DEFAULT NULL,
    `executor_cores`   bigint(255) DEFAULT NULL,
    `executor_mem`     varchar(255) DEFAULT NULL,
    `driver_mem`       varchar(255) DEFAULT NULL,
    `num`              bigint(20) DEFAULT NULL,
    `algotime`         float        DEFAULT NULL,
    `sparktime`        float        DEFAULT NULL,
    `name`             varchar(100) DEFAULT NULL COMMENT 'user define name',
    `model_saved_path` text,
    `model_type`       varchar(100) DEFAULT NULL,
    `project_id`       bigint(20) DEFAULT NULL,
    `other_info`       text,
    `param`            text,
    `status`           varchar(100) DEFAULT NULL,
    `gmt_create`       datetime     DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`       datetime     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier`     bigint(20) DEFAULT NULL,
    `gmt_creator`      bigint(20) DEFAULT NULL,
    `progress_id`      varchar(100) DEFAULT NULL,
    `runtime`          float        DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for model_local
-- ----------------------------
DROP TABLE IF EXISTS `model_local`;
CREATE TABLE `model_local`
(
    id              bigint unsigned auto_increment comment '主键',
    model_id        bigint       default 0                 not null comment '模型唯一id',
    user_id         bigint       default 0                 not null comment '用户id',
    project_id      bigint                                 null comment '项目id',
    uid             bigint                                 null comment '模型id（多版本的模型id是一样的）',
    type            int          default 1                 not null comment '模型类别',
    name            varchar(100) default ''                not null comment '模型名称',
    related_algo    varchar(100) default ''                not null comment '关联算法名称（若有多个用逗号隔开）',
    owner           varchar(100) default ''                not null comment '作者',
    profile         mediumblob                             null comment '头像信息',
    workplace       varchar(100) default ''                not null comment '工作单位',
    icon            varchar(100) default ''                not null comment 'icon',
    cover           mediumblob                             null comment '封面图片',
    public_model    tinyint      default 1                 not null comment '是否公开代码/模型',
    public_data     tinyint      default 1                 not null comment '是否公开数据',
    field           text                                   null comment '模型分类（一级分类，二级分类）',
    summary         text                                   null comment '摘要',
    keyword         text                                   null comment '关键字（逗号隔开）',
    model_desc      text                                   null comment '算法详细说明',
    star            bigint       default 0                 not null comment '收藏数',
    watch           bigint       default 0                 not null comment '点击量',
    download        bigint       default 0                 not null comment '下载量',
    version         varchar(100) default ''                not null comment '版本（年月日_序号）',
    num_version     int          default 1                 null comment '有几个版本',
    top_version     tinyint      default 1                 not null comment '是否是最新版本',
    params          text                                   null comment '参数',
    metric          text                                   null comment '指标',
    config          text                                   null comment '配置',
    status          int          default 1                 not null comment '审核状态',
    comment         text                                   null comment '审批备注',
    resource        text                                   null comment '相关资料（换行符隔开）',
    reference       text                                   null comment '参考文献（换行符隔开）',
    instruction     text                                   null comment '使用说明',
    trainable       tinyint      default 1                 not null comment '是否可训练',
    install_status  int          default 1                 not null comment '安装状态',
    train_status    int          default 1                 not null comment '训练状态',
    other_info      longtext                               null comment '其他信息',
    inference_table varchar(100) default ''                not null comment '推断输入源',
    in_panel        tinyint      default 0                 not null comment '是否在panel（1 for models in panel(not in folder); 2 for models in folder）',
    folder_id       bigint                                 null comment '文件夹id',
    run_time        bigint       default 0                 not null comment '整体运行时间',
    dataset_records bigint                                 null comment '数据量',
    progress_id     varchar(100)                           null comment 'pid/applicaiton ID',
    train_time      datetime                               null comment '训练时间',
    public_time     datetime                               null comment '发布时间',
    gmt_creator     bigint       default 0                 not null,
    gmt_create      datetime     default CURRENT_TIMESTAMP null,
    gmt_modifier    bigint       default 0                 not null,
    gmt_modify      datetime     default CURRENT_TIMESTAMP null,
    PRIMARY KEY (`id`),
    UNIQUE KEY `model_local_id_uindex` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'notice id',
    `title`        varchar(100) NOT NULL DEFAULT '' COMMENT 'notice标题',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '消息所属用户id',
    `content`      text         NOT NULL COMMENT '通知内容',
    `process`      text COMMENT '处理内容',
    `type`         tinyint(4) unsigned NOT NULL COMMENT '消息类型：1.项目角色添加 2.普通通知',
    `status`       tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '状态-0.未读 1.已读',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知消息表';

-- ----------------------------
-- Table structure for operator_favourite
-- ----------------------------
DROP TABLE IF EXISTS `operator_favourite`;
CREATE TABLE `operator_favourite`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `task_type`    int(11) NOT NULL COMMENT '任务类型',
    `alg_type`     int(11) NOT NULL COMMENT '算法类型',
    `alg_name`     varchar(20) NOT NULL DEFAULT '',
    `starred`      tinyint(1) DEFAULT '0' COMMENT '是否收藏',
    `is_edited`    tinyint(1) DEFAULT '0' COMMENT '是否可编辑',
    `desc_url`     varchar(200)         DEFAULT '' COMMENT '帮助链接',
    `gmt_create`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`   datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_creator_task_alg` (`gmt_creator`,`task_type`,`alg_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='算子收藏表';

-- ----------------------------
-- Table structure for operator_template
-- ----------------------------
DROP TABLE IF EXISTS `operator_template`;
CREATE TABLE `operator_template`
(
    `id`            bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`          varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
    `user_id`       bigint(20) unsigned NOT NULL COMMENT '所属用户id',
    `type`          tinyint(4) unsigned NOT NULL DEFAULT '4' COMMENT '类型',
    `sub_type`      tinyint(4) unsigned NOT NULL DEFAULT '7' COMMENT '子分类类型',
    `sub_type_name` varchar(100) NOT NULL DEFAULT '自定义算子' COMMENT '子类型名',
    `description`   text COMMENT '描述信息',
    `function_name` varchar(50)  NOT NULL DEFAULT '' COMMENT '函数名',
    `input_params`  text COMMENT '输入参数模板',
    `output_params` text COMMENT '输出参数模板',
    `language_type` varchar(10)           DEFAULT 'python' COMMENT '语言',
    `script_body`   text COMMENT '脚本主体',
    `sdk`           varchar(255)          DEFAULT '' COMMENT 'sdk地址',
    `status`        tinyint(4) DEFAULT '0' COMMENT '状态-0.待审核 1.已通过 2.已驳回 3.已失效',
    `suggestion`    varchar(1023)         DEFAULT NULL COMMENT '审核意见',
    `gmt_create`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`    datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`  bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`   bigint(20) NOT NULL COMMENT '初始创建者',
    `notebook_id`   varchar(20)           DEFAULT '' COMMENT '脚本唯一id,zeppelin提供',
    `interpreter`   varchar(20)           DEFAULT 'spark' COMMENT '脚本执行引擎,可选spark|madlib',
    `full_script`   text COMMENT '组装成完整可执行脚本',
    `is_export`     tinyint(4) DEFAULT '0' COMMENT '是否导出为自定义算子',
    PRIMARY KEY (`id`),
    KEY             `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='算子模板表';

-- ----------------------------
-- Table structure for pipeline
-- ----------------------------
DROP TABLE IF EXISTS `pipeline`;
CREATE TABLE `pipeline`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `data_json`    text COMMENT 'json配置',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_project` (`project_id`),
    KEY            `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pipeline_instance
-- ----------------------------
DROP TABLE IF EXISTS `pipeline_instance`;
CREATE TABLE `pipeline_instance`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `pipeline_id`  bigint(20) unsigned NOT NULL COMMENT 'pipelineId',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `status`       char(10) NOT NULL DEFAULT 'create' COMMENT 'pipeline状态',
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `during_time`  bigint(20) DEFAULT '0' COMMENT '开始执行到结束耗时',
    `gmt_running`  datetime          DEFAULT NULL COMMENT '开始执行时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pipeline_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `pipeline_snapshot`;
CREATE TABLE `pipeline_snapshot`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'pipeline快照id',
    `name`         varchar(100) NOT NULL DEFAULT '' COMMENT 'pipeline快照名称',
    `pipeline_id`  bigint(20) unsigned NOT NULL COMMENT 'pipelineId',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `picture_path` varchar(255)          DEFAULT NULL COMMENT '截图路径',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_pipeline` (`pipeline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='pipeline快照表';

-- ----------------------------
-- Table structure for plugin
-- ----------------------------
DROP TABLE IF EXISTS `plugin`;
CREATE TABLE `plugin`
(
    `id`           BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`         VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
    `token`        VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
    `status`       TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0-off  1-on',
    `url`          VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8_general_ci',
    `version`      VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8_general_ci',
    `icon_encode`  MEDIUMBLOB NULL DEFAULT NULL COMMENT '图标编码',
    `data_json`    TEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
    `description`  VARCHAR(50) NULL DEFAULT '' COLLATE 'utf8_general_ci',
    `gmt_create`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '最后修改者',
    `gmt_creator`  BIGINT(20) NOT NULL DEFAULT '0' COMMENT '初始创建者',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `name` (`name`) USING BTREE,
    UNIQUE INDEX `token` (`token`) USING BTREE
) COMMENT='插件'
    COLLATE='utf8_general_ci'
    ENGINE=InnoDB
    AUTO_INCREMENT=6
;

-- ----------------------------
-- Table structure for plugin_instance
-- ----------------------------
DROP TABLE IF EXISTS `plugin_instance`;
CREATE TABLE `plugin_instance`
(
    `id`           BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    `plugin_id`    BIGINT(20) UNSIGNED NOT NULL COMMENT '插件id',
    `user_id`      BIGINT(20) UNSIGNED NOT NULL COMMENT '用户id',
    `status`       CHAR(10) NOT NULL DEFAULT 'create' COMMENT '任务状态' COLLATE 'utf8_general_ci',
    `data_json`    TEXT NULL DEFAULT NULL COMMENT 'json结果' COLLATE 'utf8_general_ci',
    `log_info`     TEXT NULL DEFAULT NULL COMMENT '日志' COLLATE 'utf8_general_ci',
    `during_time`  BIGINT(20) NULL DEFAULT '0' COMMENT '执行时间',
    `gmt_create`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_running`  DATETIME NULL DEFAULT NULL COMMENT '开始执行时间',
    `gmt_modifier` BIGINT(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  BIGINT(20) NOT NULL COMMENT '初始创建者',
    `progress`     TINYINT(3) UNSIGNED NULL DEFAULT '0' COMMENT '任务进度',
    PRIMARY KEY (`id`) USING BTREE
) COMMENT='插件安装任务实例'
    COLLATE='utf8_general_ci'
    ENGINE=InnoDB
    AUTO_INCREMENT=30
;


-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(50)  NOT NULL DEFAULT '' COMMENT '项目名',
    `description`  varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0' COMMENT '初始创建者',
    `lock`         tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定标记：0：正常，1：锁定',
    `type`         tinyint(4) NOT NULL DEFAULT '0' COMMENT '项目类型：0：普通项目， 1：示范项目',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_name_creator` (`gmt_creator`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='项目表';

-- ----------------------------
-- Table structure for rc_audit
-- ----------------------------
DROP TABLE IF EXISTS `rc_audit`;
CREATE TABLE `rc_audit`
(
    `id`           bigint(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
    `request_time` datetime          DEFAULT NULL COMMENT '请求时间',
    `url`          varchar(511)      DEFAULT NULL COMMENT 'URL',
    `params`       varchar(2047)     DEFAULT NULL COMMENT '请求参数',
    `request_type` varchar(255)      DEFAULT NULL COMMENT '请求类型',
    `request_data` varchar(511)      DEFAULT NULL COMMENT '请求数据集/表名/视图名，可用逗号分隔',
    `username`     varchar(255)      DEFAULT NULL COMMENT '用户昵称',
    `ip`           varchar(255)      DEFAULT NULL COMMENT '请求ip地址',
    `env_info`     text COMMENT '环境信息',
    `create_time`  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录时间',
    PRIMARY KEY (`id`),
    KEY            `request_time` (`request_time`),
    KEY            `uid` (`username`),
    KEY            `request_time_2` (`request_time`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '所属用户id',
    `category_id`  bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '所属类别id',
    `data_json`    text COMMENT '数据集元信息',
    `table_names`  varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY            `idx_user` (`user_id`),
    KEY            `idx_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='推荐数据表meta信息';

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`
(
    `id`           int(20) NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) NOT NULL COMMENT '角色名',
    `description`  text COMMENT '描述',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) DEFAULT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) DEFAULT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sql_category
-- ----------------------------
DROP TABLE IF EXISTS `sql_category`;
CREATE TABLE `sql_category`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `row_sql`      varchar(200) NOT NULL DEFAULT '' COMMENT '原始SQL语句',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name`         varchar(100) NOT NULL DEFAULT '' COMMENT '名称',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `pipeline_id`  bigint(20) unsigned NOT NULL COMMENT 'pipelineId',
    `parent_id`    varchar(200) NOT NULL DEFAULT '' COMMENT '父id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `type`         tinyint(4) unsigned NOT NULL COMMENT '类型',
    `data_json`    text COMMENT 'json配置',
    `gmt_create`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier` bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`  bigint(20) NOT NULL COMMENT '初始创建者',
    `child_id`     varchar(200) NOT NULL DEFAULT '' COMMENT '子id',
    `operator_id`  bigint(20) DEFAULT '0' COMMENT 'operatorTemplate 表对应id',
    PRIMARY KEY (`id`),
    KEY            `idx_pipeline` (`pipeline_id`),
    KEY            `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for task_instance
-- ----------------------------
DROP TABLE IF EXISTS `task_instance`;
CREATE TABLE `task_instance`
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `parent_id`      varchar(200) NOT NULL DEFAULT '' COMMENT '父id',
    `task_id`        bigint(20) unsigned NOT NULL COMMENT '任务id',
    `pipeline_id`    bigint(20) unsigned NOT NULL COMMENT 'pipelineId',
    `project_id`     bigint(20) unsigned NOT NULL COMMENT '项目id',
    `user_id`        bigint(20) unsigned NOT NULL COMMENT '用户id',
    `status`         char(10)     NOT NULL DEFAULT 'create' COMMENT '任务状态',
    `data_json`      text COMMENT 'json结果',
    `sql_text`       text COMMENT '可执行sql语句',
    `output`         text COMMENT '执行结果输出',
    `session_id`     bigint(20) DEFAULT NULL COMMENT '执行sessionid',
    `log_info`       text COMMENT '日志',
    `run_times`      int(10) DEFAULT '0' COMMENT '执行次数',
    `gmt_create`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_running`    datetime              DEFAULT NULL COMMENT '开始执行时间',
    `gmt_modifier`   bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`    bigint(20) NOT NULL COMMENT '初始创建者',
    `task_name`      varchar(100) NOT NULL DEFAULT '',
    `type`           tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT 'task类型',
    `progress`       tinyint(3) unsigned DEFAULT '0' COMMENT '任务进度',
    `application_id` varchar(100)          DEFAULT NULL COMMENT 'spark的任务id',
    PRIMARY KEY (`id`),
    KEY              `idx_pipeline` (`pipeline_id`),
    KEY              `idx_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for task_instance_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `task_instance_snapshot`;
CREATE TABLE `task_instance_snapshot`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'task instance快照id',
    `pipeline_snapshot_id` bigint(20) unsigned NOT NULL COMMENT 'pipeline快照id',
    `pipeline_id`          bigint(20) unsigned NOT NULL COMMENT 'pipeline id',
    `project_id`           bigint(20) unsigned NOT NULL COMMENT '项目id',
    `task_instance_json`   text COMMENT 'task instance信息以json字符串保存',
    `gmt_create`           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`         bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`          bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY                    `idx_pipeline_snapshot` (`pipeline_snapshot_id`),
    KEY                    `idx_pipeline` (`pipeline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='task instance快照表';

-- ----------------------------
-- Table structure for task_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `task_snapshot`;
CREATE TABLE `task_snapshot`
(
    `id`                   bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'task快照id',
    `pipeline_snapshot_id` bigint(20) unsigned NOT NULL COMMENT 'pipeline快照id',
    `pipeline_id`          bigint(20) unsigned NOT NULL COMMENT 'pipeline id',
    `project_id`           bigint(20) unsigned NOT NULL COMMENT '项目id',
    `task_json`            text COMMENT 'task信息以json字符串保存',
    `gmt_create`           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`         bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`          bigint(20) NOT NULL COMMENT '初始创建者',
    PRIMARY KEY (`id`),
    KEY                    `idx_pipeline_snapshot` (`pipeline_snapshot_id`),
    KEY                    `idx_pipeline` (`pipeline_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='task快照表';

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`             bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
    `name`           varchar(50)  NOT NULL COMMENT '登录用户名',
    `email`          varchar(100) NOT NULL DEFAULT '' COMMENT '用户email',
    `status`         tinyint(4) NOT NULL DEFAULT '1' COMMENT '用户状态:1=正常;',
    `role`           tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户角色：0-普通用户，1-管理员',
    `gmt_create`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`     datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_creator`    bigint(20) unsigned zerofill NOT NULL DEFAULT '00000000000000000000' COMMENT '初始创建者',
    `gmt_modifier`   bigint(20) unsigned zerofill NOT NULL DEFAULT '00000000000000000000' COMMENT '最后修改者',
    `password`       varchar(255) NOT NULL DEFAULT '',
    `phone`          varchar(11)  NOT NULL DEFAULT '' COMMENT '手机号',
    `remark`         varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
    `nick_name`      varchar(50)           DEFAULT '' COMMENT '昵称',
    `real_name`      varchar(50)           DEFAULT '' COMMENT '真实姓名',
    `date_birth`     date                  DEFAULT '2000-01-01' COMMENT '出生日期',
    `gender`         varchar(4)            DEFAULT '' COMMENT '性别',
    `profession`     varchar(100)          DEFAULT '' COMMENT '职业',
    `work_org`       varchar(100)          DEFAULT '' COMMENT '工作单位',
    `address`        varchar(200)          DEFAULT '' COMMENT '通信地址',
    `research_field` varchar(100)          DEFAULT '' COMMENT '研究领域',
    `pic_encode`     mediumblob COMMENT '用户头像编码',
    `guide_status`   tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户引导状态：0-未引导；1-已引导',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_config
-- ----------------------------
DROP TABLE IF EXISTS `user_config`;
CREATE TABLE `user_config`
(
    `id`                                   bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id`                              bigint(20) NOT NULL,
    `notice_receive_level`                 tinyint(4) NOT NULL DEFAULT '1' COMMENT '消息接收级别，1：所有消息，2：与自己相关，3：屏蔽消息',
    `node_deletion_secondary_confirmation` tinyint(4) NOT NULL DEFAULT '1' COMMENT '数据视图中删除节点二次确认：0：关闭，1：开启',
    `gmt_create`                           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`                           datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_creator`                          bigint(20) NOT NULL DEFAULT '0',
    `gmt_modifier`                         bigint(20) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `user_feedbacks`;
CREATE TABLE `user_feedbacks`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT ' 主键id',
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户id',
    `status`       tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=未回复，1=已回复',
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0' COMMENT '初始创建者',
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后修改者',
    `feedback`     text COMMENT '用户反馈问题描述',
    `feedback_pic` mediumblob COMMENT '相关图片编码',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user_project
-- ----------------------------
DROP TABLE IF EXISTS `user_project`;
CREATE TABLE `user_project`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id`      bigint(20) unsigned NOT NULL COMMENT '用户',
    `project_id`   bigint(20) unsigned NOT NULL COMMENT '项目id',
    `role_id`      int(20) DEFAULT NULL COMMENT '角色id',
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0' COMMENT '初始创建者',
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后修改者',
    `auth`         tinyint(4) DEFAULT '1' COMMENT '读写权限：1-读，2-读写，3-管理员，有项目权限管理的权限',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_user_project` (`user_id`,`project_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户、项目权限表';

-- ----------------------------
-- Table structure for widget
-- ----------------------------
DROP TABLE IF EXISTS `widget`;
CREATE TABLE `widget`
(
    `id`                bigint(20) NOT NULL AUTO_INCREMENT,
    `tid`               bigint(20) unsigned DEFAULT NULL COMMENT 'tid',
    `project_id`        bigint(20) DEFAULT NULL COMMENT '项目Id',
    `type`              varchar(20) NOT NULL COMMENT '类型:dataset,task',
    `name`              varchar(100)         DEFAULT NULL COMMENT '名称',
    `data_json`         mediumtext CHARACTER SET utf8mb4 COMMENT '配置',
    `publish_name`      varchar(100)         DEFAULT NULL COMMENT '发布名称',
    `publish_data_json` mediumtext COMMENT '发布配置',
    `publish_time`      datetime             DEFAULT NULL COMMENT '发布时间',
    `gmt_create`        datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间',
    `gmt_modify`        datetime    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
    `gmt_modifier`      bigint(20) NOT NULL COMMENT '最后修改者',
    `gmt_creator`       bigint(20) NOT NULL COMMENT '初始创建者',
    `dashboard_id`      bigint(20) DEFAULT '0' COMMENT '画布Id',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for widget_favourite
-- ----------------------------
DROP TABLE IF EXISTS `widget_favourite`;
CREATE TABLE `widget_favourite`
(
    `id`           bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `pipeline_id`  bigint(20) unsigned NOT NULL,
    `widget_id`    bigint(20) unsigned NOT NULL,
    `gmt_create`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `gmt_modify`   datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `gmt_modifier` bigint(20) NOT NULL DEFAULT '0',
    `gmt_creator`  bigint(20) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uniq_idx_widget_pipeline_creator` (`pipeline_id`,`gmt_creator`,`widget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='可视化视图收藏表';

-- ----------------------------
-- Procedure structure for add_column
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_column`;
DELIMITER ;;
CREATE
DEFINER=`root`@`%` PROCEDURE `add_column`()
BEGIN
    SET
@table_name = "dataset";
    SET
@exeSql = CONCAT('ALTER TABLE ' , @table_name , " ADD COLUMN gmt_create datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '初始创建时间';");

PREPARE stmt FROM @exeSql;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;


SET
@exeSql = CONCAT('ALTER TABLE ' , @table_name , " ADD COLUMN gmt_modify datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间';");

PREPARE stmt FROM @exeSql;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;

SET
@exeSql = CONCAT('ALTER TABLE ' , @table_name , " ADD COLUMN  gmt_modifier BIGINT NOT NULL DEFAULT 0 COMMENT '最后修改者';");

PREPARE stmt FROM @exeSql;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;
SET
@exeSql = CONCAT('ALTER TABLE ' , @table_name , " ADD COLUMN  gmt_creator BIGINT NOT NULL DEFAULT 0 COMMENT '初始创建者';"
            );

PREPARE stmt FROM @exeSql;
EXECUTE stmt;

DEALLOCATE PREPARE stmt;

END
;;
DELIMITER ;



-- DML

INSERT INTO `data_level`
VALUES ('1', '姓名', 'name', 'L4', null, '2021-01-15 10:26:30', '2021-01-15 10:26:30', null, null);
INSERT INTO `data_level`
VALUES ('2', '身份证号', 'id_card', 'L4', null, '2021-01-15 10:27:19', '2021-01-15 10:27:19', null, null);
INSERT INTO `data_level`
VALUES ('3', '住址/通信地址', 'address', 'L4', null, '2021-01-15 10:28:01', '2021-01-15 10:28:01', null, null);
INSERT INTO `data_level`
VALUES ('4', '账号/密码', 'account', 'L4', null, '2021-01-15 10:36:04', '2021-01-15 10:36:04', null, null);
INSERT INTO `data_level`
VALUES ('5', '手机/固话', 'phone', 'L4', null, '2021-01-15 10:36:39', '2021-01-15 10:36:39', null, null);
INSERT INTO `data_level`
VALUES ('6', '电子邮箱', 'email', 'L4', null, '2021-01-15 10:37:03', '2021-01-15 10:37:03', null, null);
INSERT INTO `data_level`
VALUES ('7', '轨迹信息', 'trace_info', 'L4', null, '2021-01-15 10:37:44', '2021-01-15 10:37:44', null, null);
INSERT INTO `data_level`
VALUES ('8', '通信内容', 'communication', 'L4', null, '2021-01-15 10:38:33', '2021-01-15 10:38:33', null, null);
INSERT INTO `data_level`
VALUES ('9', '征信信息', 'credit', 'L4', null, '2021-01-15 10:38:56', '2021-01-15 10:38:56', null, null);
INSERT INTO `data_level`
VALUES ('10', '财产信息', 'property', 'L4', null, '2021-01-15 10:39:30', '2021-01-15 10:39:30', null, null);
INSERT INTO `data_level`
VALUES ('11', '住宿记录', 'accommodation', 'L3', null, '2021-01-15 10:40:32', '2021-01-15 10:40:32', null, null);
INSERT INTO `data_level`
VALUES ('12', '通信记录', 'communication_record', 'L3', null, '2021-01-19 16:08:32', '2021-01-19 16:08:32', null, null);
INSERT INTO `data_level`
VALUES ('13', '健康生理信息', 'healthy', 'L3', null, '2021-01-15 10:41:32', '2021-01-15 10:41:32', null, null);
INSERT INTO `data_level`
VALUES ('14', '交易记录', 'transaction', 'L3', null, '2021-01-19 16:08:52', '2021-01-19 16:08:52', null, null);


INSERT INTO `external_data_source`
VALUES ('1', 'mysql', 'mysql数据库', 'database',
        'data:image/png;base64,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',
        '1', '2021-07-26 13:40:25', '2021-07-26 13:40:25', null, null);
INSERT INTO `external_data_source`
VALUES ('2', 'oracle', 'oracle数据库', 'database',
        'data:image/png;base64,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',
        '1', '2021-07-26 13:40:50', '2021-07-26 13:40:50', null, null);
INSERT INTO `external_data_source`
VALUES ('3', 'rds-mysql', '阿里云rds mysql版', 'database',
        'data:image/png;base64,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',
        '1', '2021-07-26 13:41:08', '2021-07-26 13:41:08', null, null);


INSERT INTO `role`
VALUES (1, '项目创建者', NULL, '2021-3-30 14:04:33', '2021-3-30 14:04:33', 0, 0);
INSERT INTO `role`
VALUES (2, '项目管理员', NULL, '2021-3-30 14:05:44', '2021-3-30 14:05:44', 0, 0);
INSERT INTO `role`
VALUES (3, '项目开发者', NULL, '2021-3-30 14:06:28', '2021-3-30 14:06:28', 0, 0);
INSERT INTO `role`
VALUES (4, '项目访客', NULL, '2021-3-30 14:06:48', '2021-3-30 14:06:48', 0, 0);

INSERT INTO `operator_template`
VALUES (1, '自定义算子', 0, 4, 7, '自定义算子', NULL, '', NULL, NULL, 'python', NULL,
        'https://nebula-inner.lab.zjvis.net/docs/#/model?id=%e8%87%aa%e5%ae%9a%e4%b9%89%e7%ae%97%e5%ad%90', 1, NULL,
        '2021-5-12 09:49:47', '2021-6-28 18:04:02', 0, 0, '', 'spark', NULL, 2);

ALTER TABLE `aiworks`.`dashboard`
    ADD COLUMN `visitor_ids` text DEFAULT NULL COMMENT '访客Id列表' AFTER `show_watermark`;

ALTER TABLE `aiworks`.`dashboard`
    ADD COLUMN `background_img` mediumblob DEFAULT NULL COMMENT '画布背景图片' AFTER `visitor_ids`;

ALTER TABLE `aiworks`.`project`
    ADD COLUMN `engine` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT 'madlib' COMMENT '项目使用的计算引擎' AFTER `type`;

INSERT INTO `plugin` (`name`, `token`, `status`, `url`, `version`, `icon_encode`, `data_json`, `description`,
                      `gmt_modifier`, `gmt_creator`)
VALUES ('图分析', 'nqitci00moshjokkbs04p45zrzr1k0llf9112vn1', 0, '/graph-analysis', 'v1.0.0', 'iconmoxingfenxi',
        '{"git":"git@git.zjvis.org:bigdata/graph-analysis.git", "branch": "dev", "workdir": "graph-analysis"}',
        '提供了图数据可视化、样式修改、布局修改、数据统计和数据过滤等高级分析功能。', 0, 0);
-- ----------------------------
-- Table structure for gis_layers
-- ----------------------------
create table gis_layers
(
    id           bigint unsigned auto_increment
        primary key,
    layer_name   varchar(100) charset utf8mb4 default '' not null comment '图层名字',
    user_id      bigint unsigned not null comment '用户id',
    tab_id       bigint null comment '图层对应画布id',
    data_json    longtext charset utf8mb4 null comment '存gp表等信息',
    project_id   bigint unsigned not null,
    pipeline_id  bigint unsigned null,
    task_id      bigint unsigned null,
    gmt_create   datetime     default CURRENT_TIMESTAMP not null,
    gmt_modify   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    gmt_modifier bigint                                 not null,
    gmt_creator  bigint                                 not null,
    source_table varchar(100) charset utf8mb4 default '' not null comment 'layer对应的表',
    visible      tinyint      default 0                 not null comment '是否显示图层(0不显示, 1显示）',
    type         varchar(100) default ''                not null comment 'geo字段type',
    layer_order  tinyint(3) default 0 null comment '图层渲染顺序',
    view_table   varchar(100) charset utf8mb4 default '' not null comment '图层数据创建view'
);

create index pipeline_id
    on gis_layers (pipeline_id);

create index task_id
    on gis_layers (task_id);

create index user_id
    on gis_layers (user_id);

-- ----------------------------
-- Table structure for gis_tabs
-- ----------------------------
create table gis_tabs
(
    id           bigint unsigned auto_increment comment '画布id'
        primary key,
    tab_name     varchar(100) charset utf8mb4 default '' not null comment '画布名称',
    user_id      bigint unsigned not null comment '用户id',
    data_json    longtext charset utf8mb4 null comment '存画布包含的layers_id',
    project_id   bigint unsigned not null,
    pipeline_id  bigint unsigned null,
    task_id      bigint unsigned null,
    gmt_create   datetime default CURRENT_TIMESTAMP not null,
    gmt_modify   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    gmt_modifier bigint                             not null,
    gmt_creator  bigint                             not null
);

create index pipeline_id
    on gis_tabs (pipeline_id);

create index task_id
    on gis_tabs (task_id);

create index user_id
    on gis_tabs (user_id);

-- ----------------------------
-- Table structure for jhub
-- ----------------------------
CREATE TABLE `jhub` (
                        `id` bigint(20) NOT NULL,
                        `user_id` bigint(20) DEFAULT NULL,
                        `token` varchar(100) DEFAULT NULL,
                        `user_name` varchar(100) DEFAULT NULL,
                        `user_group` varchar(100) DEFAULT NULL,
                        `info` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `jhub`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `jhub_id_uindex` (`id`);

ALTER TABLE `jhub`
    MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
COMMIT;

-- -----------------------------------
-- Table structure for knowledge_graph
-- -----------------------------------
CREATE TABLE `knowledge_graph`
(
    `id` bigint(20) UNSIGNED NOT NULL,
    `project_id` bigint(20) NOT NULL DEFAULT '0',
    `user_id` bigint(20) UNSIGNED DEFAULT NULL,
    `name` varchar(20) DEFAULT NULL,
    `base_uri` varchar(100) DEFAULT NULL COMMENT 'prefix of the element uri',
    `info` longtext COMMENT 'kg infomation',
    `category` text COMMENT 'category a kg belongs(data importing -- dataset management)',
    `publish_time` datetime DEFAULT NULL,
    `gmt_creator` bigint(20) DEFAULT NULL,
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP,
    `gmt_modifier` bigint(20) DEFAULT NULL,
    `gmt_modify` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
ALTER TABLE `knowledge_graph`
    ADD PRIMARY KEY (`id`),
    ADD UNIQUE KEY `knowledge_graph_id_uindex` (`id`);
--
ALTER TABLE `knowledge_graph`
    MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1707;
COMMIT;

-- ----------------------------
-- Table structure for gis_instance
-- ----------------------------
create table gis_instance
(
    id           bigint unsigned auto_increment
        primary key,
    layer_id     bigint unsigned not null comment 'layer_id',
    user_id      bigint unsigned not null comment '用户id',
    status       char(10) default 'CREATE'          not null comment '任务状态',
    data_json    text charset utf8mb4 null comment 'json结果',
    log_info     text charset utf8mb4 null comment '日志',
    run_time     bigint   default 0 null comment '开始执行到结束耗时',
    project_id   bigint unsigned not null comment '项目id',
    pipeline_id  bigint unsigned null comment 'pipelineId',
    task_id      bigint unsigned null comment 'task_id',
    gmt_create   datetime default CURRENT_TIMESTAMP not null comment '初始创建时间',
    gmt_modify   datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '最后修改时间',
    gmt_modifier bigint                             not null comment '最后修改者',
    gmt_creator  bigint                             not null comment '初始创建者'
);

create index idx_pipeline
    on gis_instance (pipeline_id);

alter table folder
    add sub_type int null;

alter table project
    add top tinyint(4) default null comment '置顶状态';
alter table project
    add top_time datetime default null comment '置顶时间';

-- ----------------------------
-- Table structure for case_online
-- ----------------------------
CREATE TABLE `case_online`  (
                                `case_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                `case_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
                                `case_classification` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务分类',
                                `case_leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
                                `case_summarized` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
                                `case_caption` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
                                `collect_count` int(11) NULL DEFAULT NULL COMMENT '收藏量',
                                `case_url` varchar(2083) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                `video_count` int(11) NULL DEFAULT NULL COMMENT '视频播放量',
                                `case_img` varchar(2083) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
                                `case_new` int(11) NULL DEFAULT 0,
                                `case_order` int(11) NULL DEFAULT 0 COMMENT '返回顺序',
                                `favor` tinyint(1) NULL DEFAULT 0,
                                `case_date` date NULL DEFAULT '2021-10-28',
                                `case_headpicture` varchar(2083) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                                PRIMARY KEY (`case_id`) USING BTREE,
                                UNIQUE INDEX `case_online_case_id_uindex`(`case_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for case_favor
-- ----------------------------
DROP TABLE IF EXISTS `case_favor`;
CREATE TABLE `case_favor`  (
                               `user_id` int(11) NULL DEFAULT NULL,
                               `case_id` int(11) NULL DEFAULT NULL,
                               `id` int(11) NOT NULL AUTO_INCREMENT,
                               PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 234 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;

alter table gis_tabs
    add type bigint default 0 null comment '类型：0在时空分析视图 1在知识图谱';
