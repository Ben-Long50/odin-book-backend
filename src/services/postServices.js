import prisma from '../config/database.js';

const postServices = {
  getFollowedPosts: async (profileId) => {
    try {
      const followedProfiles = await prisma.follow.findMany({
        where: { followerId: Number(profileId) },
        select: { profileId: true },
      });

      const followedProfileIds = followedProfiles.map(
        (follow) => follow.profileId,
      );

      const posts = await prisma.post.findMany({
        where: { profileId: { in: followedProfileIds } },
        orderBy: { createdAt: 'desc' },
        include: {
          profile: true,
          likes: true,
          comments: {
            include: {
              profile: true,
              likes: true,
            },
          },
        },
      });

      return posts;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to get feed posts');
    }
  },

  getExplorePosts: async (activeId) => {
    try {
      const followedProfiles = await prisma.follow.findMany({
        where: { followerId: Number(activeId) },
        select: { profileId: true },
      });

      const followedProfileIds = followedProfiles.map(
        (follow) => follow.profileId,
      );

      const posts = await prisma.post.findMany({
        where: { profileId: { notIn: followedProfileIds } },
        orderBy: { createdAt: 'desc' },
        include: {
          profile: {
            include: {
              followers: true,
            },
          },
          likes: true,
          comments: {
            include: {
              profile: true,
              likes: true,
            },
          },
        },
      });

      return posts;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to get explore posts');
    }
  },

  likePost: async (postId, profileId) => {
    try {
      await prisma.postLike.create({
        data: {
          postId: Number(postId),
          profileId: Number(profileId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to like post');
    }
  },

  unlikePost: async (postId, profileId) => {
    try {
      await prisma.postLike.delete({
        where: {
          postLikeId: {
            postId: Number(postId),
            profileId: Number(profileId),
          },
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to unlike post');
    }
  },

  createComment: async (postId, profileId, comment) => {
    try {
      await prisma.comment.create({
        data: {
          postId: Number(postId),
          profileId: Number(profileId),
          body: comment,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to comment');
    }
  },

  deleteComment: async (commentId) => {
    try {
      await prisma.comment.delete({
        where: {
          id: Number(commentId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to delete comment');
    }
  },
};

export default postServices;
