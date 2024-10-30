import prisma from '../config/database.js';

const postServices = {
  getPostById: async (postId) => {
    try {
      const post = await prisma.post.findUnique({
        where: { id: Number(postId) },
      });
      return post;
    } catch (error) {
      throw new Error(`Failed to find post: ${error.message}`);
    }
  },

  getFollowedPosts: async (profileId, page, pageSize) => {
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
        skip: (page - 1) * pageSize,
        take: pageSize,
      });

      const totalPosts = await prisma.post.count({
        where: { profileId: { in: followedProfileIds } },
      });

      const hasMore = totalPosts > page * pageSize;

      return { posts, totalPosts, hasMore };
    } catch (error) {
      console.error(error);
      throw new Error('Failed to get feed posts');
    }
  },

  deletePost: async (postId) => {
    try {
      await prisma.post.delete({
        where: {
          id: Number(postId),
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to delete post');
    }
  },

  getExplorePosts: async (activeId, page, pageSize) => {
    try {
      const followedProfiles = await prisma.follow.findMany({
        where: { followerId: Number(activeId) },
        select: { profileId: true },
      });

      const followedProfileIds = followedProfiles.map(
        (follow) => follow.profileId,
      );

      const posts = await prisma.post.findMany({
        where: {
          profileId: { notIn: [...followedProfileIds, Number(activeId)] },
        },
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
        skip: (page - 1) * pageSize,
        take: pageSize,
      });

      const totalPosts = await prisma.post.count({
        where: {
          profileId: { notIn: [...followedProfileIds, Number(activeId)] },
        },
      });

      const hasMore = totalPosts > page * pageSize;

      return { posts, totalPosts, hasMore };
    } catch (error) {
      console.error(error);
      throw new Error('Failed to get explore posts');
    }
  },

  likePost: async (postId, profileId) => {
    try {
      const postLike = await prisma.postLike.create({
        data: {
          postId: Number(postId),
          profileId: Number(profileId),
        },
      });

      const post = await prisma.post.findUnique({
        where: { id: Number(postId) },
        select: {
          profileId: true,
        },
      });

      return { postLike, post };
    } catch (error) {
      console.error(error);
      throw new Error('Failed to like post');
    }
  },

  unlikePost: async (postId, profileId) => {
    try {
      await prisma.postLike.delete({
        where: {
          profileId_postId: {
            profileId: Number(profileId),
            postId: Number(postId),
          },
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to unlike post');
    }
  },

  createComment: async (postId, profileId, commentBody) => {
    try {
      const comment = await prisma.comment.create({
        data: {
          postId: Number(postId),
          profileId: Number(profileId),
          body: commentBody,
        },
      });
      return comment;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to comment');
    }
  },
};

export default postServices;
