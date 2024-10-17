import prisma from '../config/database.js';

const commentServices = {
  likeComment: async (commentId, profileId) => {
    try {
      const commentLike = await prisma.commentLike.create({
        data: {
          commentId: Number(commentId),
          profileId: Number(profileId),
        },
      });

      const comment = await prisma.comment.findUnique({
        where: { id: Number(commentId) },
        select: {
          profileId: true,
        },
      });

      return { commentLike, comment };
    } catch (error) {
      console.error(error);
      throw new Error('Failed to like comment');
    }
  },

  unlikeComment: async (commentId, profileId) => {
    try {
      await prisma.commentLike.delete({
        where: {
          profileId_commentId: {
            profileId: Number(profileId),
            commentId: Number(commentId),
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
