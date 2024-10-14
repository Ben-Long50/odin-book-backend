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
          comments: true,
        },
      });

      return posts;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to follow profile');
    }
  },

  getPostLikes: async (postId) => {
    try {
      const postLikes = await prisma.postLike.findMany({
        where: {
          postId: Number(postId),
        },
      });
      return postLikes;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to like post');
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
      throw new Error('Failed to like post');
    }
  },
};

export default postServices;
