import prisma from '../config/database.js';

const commentServices = {
  likeComment: async (commentId, profileId) => {
    try {
      await prisma.commentLike.create({
        data: {
          commentId: Number(commentId),
          profileId: Number(profileId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to like comment');
    }
  },

  unlikeComment: async (commentId, profileId) => {
    try {
      await prisma.commentLike.delete({
        where: {
          commentLikeId: {
            commentId: Number(commentId),
            profileId: Number(profileId),
          },
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to unlike comment');
    }
  },
};

export default commentServices;
