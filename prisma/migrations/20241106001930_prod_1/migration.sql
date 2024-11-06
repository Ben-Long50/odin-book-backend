/*
  Warnings:

  - You are about to drop the column `authorId` on the `Comment` table. All the data in the column will be lost.
  - You are about to drop the column `authorId` on the `Post` table. All the data in the column will be lost.
  - You are about to drop the `Like` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_UserFriends` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[username]` on the table `Profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[googleId]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[facebookId]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `profileId` to the `Post` table without a default value. This is not possible if the table is not empty.
  - Made the column `mediaUrl` on table `Post` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `active` to the `Profile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `petName` to the `Profile` table without a default value. This is not possible if the table is not empty.
  - Made the column `username` on table `Profile` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('USER', 'GUEST');

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_postId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_commentId_fkey";

-- DropForeignKey
ALTER TABLE "Like" DROP CONSTRAINT "Like_postId_fkey";

-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_userId_fkey";

-- DropForeignKey
ALTER TABLE "_UserFriends" DROP CONSTRAINT "_UserFriends_A_fkey";

-- DropForeignKey
ALTER TABLE "_UserFriends" DROP CONSTRAINT "_UserFriends_B_fkey";

-- DropIndex
DROP INDEX "Profile_userId_key";

-- AlterTable
ALTER TABLE "Comment" DROP COLUMN "authorId",
ADD COLUMN     "profileId" INTEGER;

-- AlterTable
ALTER TABLE "Post" DROP COLUMN "authorId",
ADD COLUMN     "mediaUploadId" TEXT,
ADD COLUMN     "profileId" INTEGER NOT NULL,
ALTER COLUMN "mediaUrl" SET NOT NULL,
ALTER COLUMN "published" SET DEFAULT true;

-- AlterTable
ALTER TABLE "Profile" ADD COLUMN     "active" BOOLEAN NOT NULL,
ADD COLUMN     "breed" TEXT,
ADD COLUMN     "petName" TEXT NOT NULL,
ADD COLUMN     "profilePicUploadId" TEXT,
ALTER COLUMN "username" SET NOT NULL;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "facebookId" TEXT,
ADD COLUMN     "googleId" TEXT,
ADD COLUMN     "role" "UserRole" NOT NULL,
ALTER COLUMN "password" DROP NOT NULL;

-- DropTable
DROP TABLE "Like";

-- DropTable
DROP TABLE "_UserFriends";

-- CreateTable
CREATE TABLE "Follow" (
    "profileId" INTEGER NOT NULL,
    "followerId" INTEGER NOT NULL,

    CONSTRAINT "Follow_pkey" PRIMARY KEY ("profileId","followerId")
);

-- CreateTable
CREATE TABLE "PostLike" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "postId" INTEGER NOT NULL,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "PostLike_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CommentLike" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "commentId" INTEGER NOT NULL,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "CommentLike_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Search" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "searchedProfileId" INTEGER NOT NULL,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "Search_pkey" PRIMARY KEY ("searchedProfileId","profileId")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "followerId" INTEGER,
    "followingId" INTEGER,
    "commentId" INTEGER,
    "postLikeId" INTEGER,
    "commentLikeId" INTEGER,
    "postId" INTEGER,
    "notifiedProfileId" INTEGER NOT NULL,
    "profileId" INTEGER NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bookmark" (
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "profileId" INTEGER NOT NULL,
    "postId" INTEGER NOT NULL,

    CONSTRAINT "Bookmark_pkey" PRIMARY KEY ("profileId","postId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Follow_profileId_followerId_key" ON "Follow"("profileId", "followerId");

-- CreateIndex
CREATE UNIQUE INDEX "PostLike_profileId_postId_key" ON "PostLike"("profileId", "postId");

-- CreateIndex
CREATE UNIQUE INDEX "CommentLike_profileId_commentId_key" ON "CommentLike"("profileId", "commentId");

-- CreateIndex
CREATE UNIQUE INDEX "Bookmark_profileId_postId_key" ON "Bookmark"("profileId", "postId");

-- CreateIndex
CREATE UNIQUE INDEX "Profile_username_key" ON "Profile"("username");

-- CreateIndex
CREATE UNIQUE INDEX "User_googleId_key" ON "User"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "User_facebookId_key" ON "User"("facebookId");

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follow" ADD CONSTRAINT "Follow_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Follow" ADD CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Post" ADD CONSTRAINT "Post_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostLike" ADD CONSTRAINT "PostLike_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PostLike" ADD CONSTRAINT "PostLike_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommentLike" ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommentLike" ADD CONSTRAINT "CommentLike_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_searchedProfileId_fkey" FOREIGN KEY ("searchedProfileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Search" ADD CONSTRAINT "Search_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_followingId_followerId_fkey" FOREIGN KEY ("followingId", "followerId") REFERENCES "Follow"("profileId", "followerId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_postLikeId_fkey" FOREIGN KEY ("postLikeId") REFERENCES "PostLike"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_commentLikeId_fkey" FOREIGN KEY ("commentLikeId") REFERENCES "CommentLike"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_notifiedProfileId_fkey" FOREIGN KEY ("notifiedProfileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bookmark" ADD CONSTRAINT "Bookmark_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "Profile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bookmark" ADD CONSTRAINT "Bookmark_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;
