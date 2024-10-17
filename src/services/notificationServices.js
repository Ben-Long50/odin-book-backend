import prisma from '../config/database.js';

const notificationServices = {
  createFollowNotification: async (activeId, profileId) => {
    try {
      await prisma.notification.create({
        data: {
          profileId: Number(activeId),
          notifiedProfileId: Number(profileId),
          followerId: Number(activeId),
          followingId: Number(profileId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to send follow notification');
    }
  },

  createCommentNotification: async (profileId, activeId, commentId) => {
    try {
      await prisma.notification.create({
        data: {
          profileId: Number(activeId),
          notifiedProfileId: Number(profileId),
          commentId: Number(commentId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to send comment notification');
    }
  },

  createPostLikeNotification: async (activeId, profileId, postLikeId) => {
    try {
      await prisma.notification.create({
        data: {
          profileId: Number(activeId),
          notifiedProfileId: Number(profileId),
          postLikeId: Number(postLikeId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to send post like notification');
    }
  },

  createCommentLikeNotification: async (activeId, profileId, commentLikeId) => {
    try {
      await prisma.notification.create({
        data: {
          profileId: Number(activeId),
          notifiedProfileId: Number(profileId),
          commentLikeId: Number(commentLikeId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to send comment like notification');
    }
  },
};

export default notificationServices;
