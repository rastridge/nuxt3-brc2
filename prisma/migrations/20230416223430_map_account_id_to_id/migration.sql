-- CreateTable
CREATE TABLE `inbrc_accounts` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `account_pass` VARCHAR(32) NOT NULL DEFAULT '',
    `account_email` VARCHAR(100) NOT NULL DEFAULT '',
    `account_email_opening` DATETIME(0) NOT NULL DEFAULT '1970-01-01 00:00:01',
    `account_textmsg_opening` DATETIME(0) NOT NULL DEFAULT '1970-01-01 00:00:01',
    `account_screenname` VARCHAR(100) NOT NULL DEFAULT '',
    `last_login_ip` VARCHAR(15) NOT NULL DEFAULT '',
    `last_login_host` VARCHAR(100) NOT NULL,
    `last_login_dt` DATETIME(0) NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '1970-01-01 00:00:01',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `account_addr_street` VARCHAR(100) NOT NULL,
    `account_addr_street_ext` VARCHAR(100) NOT NULL,
    `account_addr_city` VARCHAR(100) NOT NULL DEFAULT '',
    `account_addr_state` VARCHAR(100) NOT NULL DEFAULT '',
    `account_addr_country` VARCHAR(100) NOT NULL DEFAULT '',
    `account_addr_postal` VARCHAR(15) NOT NULL DEFAULT '',
    `account_addr_phone` VARCHAR(20) NOT NULL DEFAULT '999-999-9999',
    `newsletter_recipient` INTEGER NOT NULL DEFAULT 1,
    `sms_recipient` INTEGER NOT NULL DEFAULT 1,
    `mail_recipient` INTEGER NOT NULL DEFAULT 0,
    `newsletter_format` VARCHAR(50) NOT NULL DEFAULT 'HTML',
    `member_firstname` VARCHAR(50) NOT NULL,
    `member_lastname` VARCHAR(50) NOT NULL,
    `member_dob` DATE NULL DEFAULT '1970-01-01',
    `member_nickname` VARCHAR(50) NULL,
    `member_position` VARCHAR(50) NULL DEFAULT '',
    `member_year` VARCHAR(4) NOT NULL,
    `member_prev_club` VARCHAR(50) NULL,
    `member_show_addr` BOOLEAN NOT NULL DEFAULT false,
    `member_show_phone` BOOLEAN NOT NULL DEFAULT true,
    `member_admin_type_id` INTEGER NOT NULL DEFAULT 0,
    `member_admin_type2_id` INTEGER NULL,
    `member_type_id` INTEGER NOT NULL DEFAULT 99,
    `member_type2_id` INTEGER NULL,
    `member_wall_of_fame_year` VARCHAR(4) NOT NULL,
    `member_pic_path` VARCHAR(255) NOT NULL DEFAULT '',
    `member_gender` VARCHAR(1) NULL DEFAULT 'm',
    `member_guardian` VARCHAR(100) NULL,
    `flag_legal` INTEGER NULL DEFAULT 1,
    `flag_photo` INTEGER NULL DEFAULT 1,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_accounts_play` (
    `account_id` INTEGER NOT NULL AUTO_INCREMENT,
    `account_email` VARCHAR(100) NOT NULL DEFAULT '',
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `member_firstname` VARCHAR(50) NOT NULL,
    `member_lastname` VARCHAR(50) NOT NULL,
    `comment` VARCHAR(255) NOT NULL,
    `member_pic_path` VARCHAR(255) NOT NULL DEFAULT '',

    PRIMARY KEY (`account_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_admin_apps` (
    `admin_app_id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_app_name` VARCHAR(50) NOT NULL DEFAULT '',
    `admin_app_path` VARCHAR(100) NOT NULL DEFAULT '',

    PRIMARY KEY (`admin_app_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_admin_perms` (
    `admin_perm_id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_app_id` INTEGER NOT NULL DEFAULT 0,
    `admin_user_id` INTEGER NOT NULL DEFAULT 0,
    `admin_perm` INTEGER NOT NULL DEFAULT 1,

    PRIMARY KEY (`admin_perm_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_admin_users` (
    `admin_user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_user_name` VARCHAR(50) NOT NULL DEFAULT '',
    `admin_user_pass` VARCHAR(100) NOT NULL DEFAULT '',
    `admin_user_remind` VARCHAR(100) NOT NULL DEFAULT '',
    `admin_user_email` VARCHAR(100) NOT NULL DEFAULT '',
    `last_login_ip` VARCHAR(15) NULL,
    `last_login_host` VARCHAR(100) NULL,
    `last_login_dt` DATETIME(0) NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `admin_user_name_ref`(`admin_user_name`),
    INDEX `admin_user_pass_ref`(`admin_user_pass`),
    PRIMARY KEY (`admin_user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_ads` (
    `ad_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ad_client_id` INTEGER NOT NULL DEFAULT 0,
    `ad_title` VARCHAR(200) NOT NULL DEFAULT '',
    `ad_url` VARCHAR(255) NOT NULL DEFAULT '',
    `ad_path` VARCHAR(255) NOT NULL DEFAULT '',
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`ad_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_ads_activity` (
    `ad_activity_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ad_id` INTEGER NOT NULL DEFAULT 0,
    `ad_view_cnt` INTEGER NOT NULL DEFAULT 0,
    `ad_click_cnt` INTEGER NOT NULL DEFAULT 0,
    `ad_activity_month` INTEGER NOT NULL DEFAULT 0,
    `ad_activity_year` INTEGER NOT NULL DEFAULT 0,

    INDEX `ad_id_rel`(`ad_id`),
    PRIMARY KEY (`ad_activity_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_ads_clients` (
    `ad_client_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ad_client_name` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_contact` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_email` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_phone` VARCHAR(20) NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`ad_client_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_archive` (
    `archive_id` INTEGER NOT NULL AUTO_INCREMENT,
    `archive_title` VARCHAR(50) NOT NULL,
    `archive_description` VARCHAR(100) NOT NULL,
    `archive_filepath` VARCHAR(100) NOT NULL,
    `archive_category` VARCHAR(50) NOT NULL,
    `archive_date` DATETIME(0) NOT NULL,
    `status` TINYINT NOT NULL,
    `deleted` TINYINT NOT NULL,
    `deleted_dt` DATETIME(0) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`archive_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_availability` (
    `availability_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_id` INTEGER NOT NULL,
    `player_id` INTEGER NOT NULL,
    `availability` VARCHAR(3) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`availability_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_availability_2022-03-02` (
    `availability_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_id` INTEGER NOT NULL,
    `player_id` INTEGER NOT NULL,
    `availability` VARCHAR(3) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`availability_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_clubhouse` (
    `clubhouse_id` INTEGER NOT NULL AUTO_INCREMENT,
    `clubhouse_title` VARCHAR(255) NOT NULL,
    `clubhouse_description` VARCHAR(255) NOT NULL,
    `clubhouse_filepath` VARCHAR(100) NOT NULL,
    `clubhouse_category` VARCHAR(50) NOT NULL,
    `clubhouse_owner` VARCHAR(100) NOT NULL,
    `clubhouse_date` INTEGER NOT NULL DEFAULT 1966,
    `status` TINYINT NOT NULL,
    `deleted` TINYINT NOT NULL,
    `deleted_dt` DATETIME(0) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`clubhouse_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_community_links` (
    `community_link_id` INTEGER NOT NULL AUTO_INCREMENT,
    `account_id` INTEGER NOT NULL DEFAULT 0,
    `community_link_title` VARCHAR(50) NOT NULL,
    `community_link_organization` VARCHAR(50) NOT NULL,
    `community_link_phone` VARCHAR(17) NOT NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `account_id_ref`(`account_id`),
    PRIMARY KEY (`community_link_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_content` (
    `content_id` INTEGER NOT NULL AUTO_INCREMENT,
    `content_name` VARCHAR(50) NOT NULL DEFAULT '',
    `content_body` LONGTEXT NOT NULL,
    `content_order` INTEGER NOT NULL DEFAULT 0,
    `status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `content_release_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `content_expire_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`content_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_contributions` (
    `contribution_id` INTEGER NOT NULL AUTO_INCREMENT,
    `account_id` INTEGER NOT NULL DEFAULT 0,
    `contribution_amount` INTEGER NOT NULL,
    `contribution_date` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `contribution_comment` TEXT NOT NULL,
    `contribution_showName` INTEGER NOT NULL DEFAULT 1,
    `contribution_showAmount` INTEGER NOT NULL DEFAULT 1,
    `Status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `account_id_ref`(`account_id`),
    PRIMARY KEY (`contribution_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_images` (
    `image_id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `alt` VARCHAR(100) NOT NULL,
    `url` VARCHAR(100) NOT NULL,
    `description` VARCHAR(100) NOT NULL,
    `gallery` BOOLEAN NOT NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modified_dt` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_dt` DATETIME(0) NOT NULL,
    `deleted` BOOLEAN NOT NULL,
    `status` BOOLEAN NOT NULL,

    PRIMARY KEY (`image_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_leaders` (
    `leaders_year` INTEGER NOT NULL,
    `president` VARCHAR(50) NOT NULL,
    `vice_president` VARCHAR(50) NOT NULL,
    `match_secretary` VARCHAR(50) NOT NULL,
    `treasurer` VARCHAR(50) NOT NULL,
    `spring_captain` VARCHAR(50) NOT NULL,
    `fall_captain` VARCHAR(50) NOT NULL,
    `coach` VARCHAR(50) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`leaders_year`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_member_admin_types` (
    `member_admin_type_id` INTEGER NOT NULL,
    `member_admin_type` VARCHAR(50) NOT NULL DEFAULT '',

    PRIMARY KEY (`member_admin_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_member_types` (
    `member_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `member_type` VARCHAR(50) NOT NULL DEFAULT '',
    `Status` INTEGER NOT NULL DEFAULT 1,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`member_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_news` (
    `news_id` INTEGER NOT NULL AUTO_INCREMENT,
    `news_type_id` INTEGER NOT NULL DEFAULT 1,
    `news_title` VARCHAR(255) NOT NULL DEFAULT '',
    `news_synop` VARCHAR(255) NOT NULL,
    `news_article` TEXT NOT NULL,
    `news_event_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `news_release_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `news_expire_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `news_type_rel`(`news_type_id`),
    PRIMARY KEY (`news_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_news_testing` (
    `news_id` INTEGER NOT NULL AUTO_INCREMENT,
    `news_type_id` INTEGER NOT NULL DEFAULT 1,
    `news_title` VARCHAR(255) NOT NULL DEFAULT '',
    `news_synop` VARCHAR(255) NOT NULL,
    `news_article` TEXT NOT NULL,
    `news_event_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `news_release_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `news_expire_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NULL,
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `news_type_rel`(`news_type_id`),
    PRIMARY KEY (`news_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_news_types` (
    `news_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `news_type` VARCHAR(50) NOT NULL DEFAULT '',

    PRIMARY KEY (`news_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_newsletter_openings` (
    `openings_id` INTEGER NOT NULL AUTO_INCREMENT,
    `newsletter_id` INTEGER NOT NULL,
    `account_id` INTEGER NOT NULL DEFAULT 0,
    `account_email` VARCHAR(50) NOT NULL,
    `newsletter_subject` VARCHAR(255) NOT NULL DEFAULT '',
    `newsletter_opened_date` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `status` INTEGER NOT NULL DEFAULT 0,
    `deleted` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`openings_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_newsletter_recipient_types` (
    `newsletter_recipient_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `newsletter_recipient_type` VARCHAR(50) NOT NULL DEFAULT '',
    `Status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`newsletter_recipient_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_newsletters` (
    `newsletter_id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_user_id` INTEGER NOT NULL DEFAULT 0,
    `newsletter_member_type_id` INTEGER NOT NULL DEFAULT 0,
    `newsletter_recipient_type_id` INTEGER NOT NULL DEFAULT 0,
    `newsletter_subject` VARCHAR(255) NOT NULL DEFAULT '',
    `newsletter_body_text` VARCHAR(100) NOT NULL DEFAULT '""',
    `newsletter_body_html` TEXT NOT NULL,
    `newsletter_send` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `newsletter_sent` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `newsletter_send_complete` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `newsletter_recp_cnt` INTEGER NOT NULL DEFAULT 0,
    `newsletter_opened_cnt` INTEGER NOT NULL DEFAULT 0,
    `newsletter_send_status` INTEGER NOT NULL DEFAULT 0,
    `status` INTEGER NOT NULL DEFAULT 0,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `admin_user_id`(`admin_user_id`),
    PRIMARY KEY (`newsletter_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_opponents` (
    `opponent_id` INTEGER NOT NULL AUTO_INCREMENT,
    `opponent_name` VARCHAR(100) NOT NULL,
    `opponent_description` VARCHAR(100) NOT NULL,
    `opponent_level` VARCHAR(10) NOT NULL,
    `opponent_location` VARCHAR(100) NOT NULL,
    `opponent_type` VARCHAR(50) NOT NULL,
    `status` TINYINT NOT NULL,
    `deleted` TINYINT NOT NULL,
    `deleted_dt` DATETIME(0) NOT NULL,
    `created_dt` DATETIME(0) NOT NULL,
    `modified_dt` DATETIME(0) NOT NULL,

    PRIMARY KEY (`opponent_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_payments` (
    `payment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `payment_title` VARCHAR(100) NOT NULL DEFAULT '',
    `payment_description` LONGTEXT NOT NULL,
    `payment_paypal_button` LONGTEXT NOT NULL,
    `release_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `expire_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`payment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_resume` (
    `resume_id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `account_id` INTEGER NOT NULL,
    `job_type` TEXT NOT NULL,
    `resume_text` TEXT NOT NULL,
    `resume_release_dt` DATETIME(0) NOT NULL,
    `resume_expire_dt` DATETIME(0) NOT NULL,
    `STATUS` INTEGER UNSIGNED NOT NULL DEFAULT 1,
    `created_dt` TIMESTAMP(0) NOT NULL,
    `modified_dt` TIMESTAMP(0) NOT NULL,

    PRIMARY KEY (`resume_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_sms` (
    `sms_id` INTEGER NOT NULL AUTO_INCREMENT,
    `admin_user_id` INTEGER NOT NULL DEFAULT 0,
    `sms_member_type_id` INTEGER NOT NULL DEFAULT 0,
    `sms_recipient_type_id` INTEGER NOT NULL DEFAULT 0,
    `sms_subject` VARCHAR(255) NOT NULL,
    `sms_body_text` TEXT NOT NULL,
    `sms_sent` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `sms_send_complete` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `sms_recp_cnt` INTEGER NOT NULL DEFAULT 0,
    `sms_err_cnt` INTEGER NOT NULL DEFAULT 0,
    `sms_send_status` INTEGER NOT NULL DEFAULT 0,
    `status` INTEGER NOT NULL DEFAULT 0,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `admin_user_id`(`admin_user_id`),
    PRIMARY KEY (`sms_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_sponsors` (
    `ad_client_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ad_client_name` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_contact` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_email` VARCHAR(100) NOT NULL DEFAULT '',
    `ad_client_phone` VARCHAR(20) NOT NULL,
    `ad_client_website` VARCHAR(100) NOT NULL,
    `ad_image_path` VARCHAR(100) NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`ad_client_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_stats_game_types` (
    `game_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_type` VARCHAR(50) NOT NULL DEFAULT '',

    PRIMARY KEY (`game_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_stats_games` (
    `game_id` INTEGER NOT NULL AUTO_INCREMENT,
    `opponent_id` INTEGER NOT NULL,
    `referee` VARCHAR(100) NOT NULL DEFAULT '',
    `venue` VARCHAR(100) NOT NULL DEFAULT '',
    `comment` VARCHAR(255) NOT NULL DEFAULT '',
    `date` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `game_type_id` INTEGER NULL,
    `game_level` ENUM('A', 'B', 'C', 'D') NULL,
    `occasion` VARCHAR(100) NOT NULL,
    `ptsFor` INTEGER NULL,
    `ptsAgn` INTEGER NULL,
    `result` VARCHAR(10) NOT NULL,
    `game_pic_path` VARCHAR(100) NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    UNIQUE INDEX `game_id`(`game_id`),
    PRIMARY KEY (`game_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_stats_games_2022-02-06` (
    `game_id` INTEGER NOT NULL AUTO_INCREMENT,
    `opponent` VARCHAR(100) NOT NULL DEFAULT '',
    `opponent_id` INTEGER NOT NULL,
    `referee` VARCHAR(100) NOT NULL DEFAULT '',
    `venue` VARCHAR(100) NOT NULL DEFAULT '',
    `comment` VARCHAR(255) NOT NULL DEFAULT '',
    `date` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `game_type_id` INTEGER NULL,
    `game_level` ENUM('A', 'B', 'C', 'D') NULL,
    `occasion` VARCHAR(100) NOT NULL,
    `ptsFor` INTEGER NULL,
    `ptsAgn` INTEGER NULL,
    `result` VARCHAR(10) NOT NULL,
    `game_pic_path` VARCHAR(100) NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    UNIQUE INDEX `game_id`(`game_id`),
    PRIMARY KEY (`game_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_stats_player` (
    `scoring_id` INTEGER NOT NULL AUTO_INCREMENT,
    `position_id` INTEGER NOT NULL DEFAULT 0,
    `player_id` INTEGER NOT NULL DEFAULT 0,
    `game_id` INTEGER NOT NULL DEFAULT 0,
    `replaced_by` INTEGER NOT NULL DEFAULT 0,
    `tries` INTEGER NULL DEFAULT 0,
    `assists` INTEGER NULL DEFAULT 0,
    `conv` INTEGER NULL DEFAULT 0,
    `penk` INTEGER NULL DEFAULT 0,
    `dgoal` INTEGER NULL DEFAULT 0,
    `yellow` INTEGER NULL DEFAULT 0,
    `red` INTEGER NULL DEFAULT 0,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `game_id`(`game_id`),
    INDEX `player_id`(`player_id`),
    PRIMARY KEY (`scoring_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_stats_player_2022_01_20` (
    `scoring_id` INTEGER NOT NULL AUTO_INCREMENT,
    `position_id` INTEGER NOT NULL DEFAULT 0,
    `player_id` INTEGER NOT NULL DEFAULT 0,
    `game_id` INTEGER NOT NULL DEFAULT 0,
    `replaced_by` INTEGER NOT NULL DEFAULT 0,
    `tries` INTEGER NULL DEFAULT 0,
    `assists` INTEGER NULL DEFAULT 0,
    `conv` INTEGER NULL DEFAULT 0,
    `penk` INTEGER NULL DEFAULT 0,
    `dgoal` INTEGER NULL DEFAULT 0,
    `yellow` INTEGER NULL DEFAULT 0,
    `red` INTEGER NULL DEFAULT 0,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `game_id`(`game_id`),
    INDEX `player_id`(`player_id`),
    PRIMARY KEY (`scoring_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_supportingaccts` (
    `supportingApp_id` INTEGER NOT NULL AUTO_INCREMENT,
    `supportingApp_name` VARCHAR(100) NOT NULL,
    `supportingApp_description` MEDIUMTEXT NOT NULL,
    `supportingApp_url` VARCHAR(200) NOT NULL,
    `supportingApp_owner` VARCHAR(100) NOT NULL,
    `supportingApp_username` VARCHAR(100) NOT NULL,
    `supportingApp_password` VARCHAR(100) NOT NULL,
    `status` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`supportingApp_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_video` (
    `video_id` INTEGER NOT NULL AUTO_INCREMENT,
    `video_type_id` INTEGER NOT NULL DEFAULT 1,
    `video_title` VARCHAR(255) NOT NULL,
    `video_synop` VARCHAR(255) NOT NULL,
    `video_url` TEXT NOT NULL,
    `video_event_dt` DATE NOT NULL DEFAULT '0000-00-00',
    `video_release_dt` DATE NOT NULL DEFAULT '0000-00-00',
    `video_expire_dt` DATE NOT NULL DEFAULT '0000-00-00',
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    INDEX `news_type_rel`(`video_type_id`),
    PRIMARY KEY (`video_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_video_types` (
    `video_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `video_type` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`video_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes` (
    `vote_question_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_vote_cnt` INTEGER NOT NULL DEFAULT 0,
    `vote_question` TEXT NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`vote_question_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes_2022-01-26` (
    `vote_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_vote_cnt` INTEGER NOT NULL DEFAULT 0,
    `vote_question` TEXT NOT NULL,
    `STATUS` INTEGER NOT NULL DEFAULT 1,
    `deleted` INTEGER NOT NULL DEFAULT 0,
    `deleted_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `created_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',
    `modified_dt` DATETIME(0) NOT NULL DEFAULT '0000-00-00 00:00:00',

    PRIMARY KEY (`vote_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes_answers_2022-01-26` (
    `vote_answer_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_id` INTEGER NOT NULL DEFAULT 0,
    `vote_answer` TEXT NOT NULL,
    `vote_answer_cnt` INTEGER NOT NULL DEFAULT 0,

    INDEX `poll_id_rel`(`vote_id`),
    PRIMARY KEY (`vote_answer_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes_choices` (
    `vote_choice_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_question_id` INTEGER NOT NULL DEFAULT 0,
    `vote_choice` TEXT NOT NULL,
    `vote_picked_cnt` INTEGER NOT NULL DEFAULT 0,

    INDEX `poll_id_rel`(`vote_question_id`),
    PRIMARY KEY (`vote_choice_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes_voted` (
    `voted_voted_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_question_id` INTEGER NOT NULL,
    `voted_email` TEXT NOT NULL,
    `vote_date` DATETIME(0) NOT NULL,

    INDEX `poll_id_rel`(`vote_question_id`),
    PRIMARY KEY (`voted_voted_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `inbrc_votes_voted_2022-01-26` (
    `voted_voted_id` INTEGER NOT NULL AUTO_INCREMENT,
    `vote_id` INTEGER NOT NULL,
    `voted_email` TEXT NOT NULL,
    `vote_date` DATETIME(0) NOT NULL,

    INDEX `poll_id_rel`(`vote_id`),
    PRIMARY KEY (`voted_voted_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
