/*
  Warnings:

  - The primary key for the `inbrc_accounts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `inbrc_accounts` table. All the data in the column will be lost.
  - Added the required column `account_id` to the `inbrc_accounts` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `inbrc_accounts` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `account_id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `created_dt` DATETIME(0) NOT NULL DEFAULT '1970-01-01 00:00:01',
    MODIFY `modified_dt` DATETIME(0) NOT NULL DEFAULT '1970-01-01 00:00:01',
    ADD PRIMARY KEY (`account_id`);
