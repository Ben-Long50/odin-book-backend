import prisma from '../config/database.js';

const postServices = {
  getFollowedPosts: async (profileId) => {
    try {
      const followedProfiles = await prisma.follow.findMany({
        where: { followerId: Number(profileId) },
        select: { profileId: true },
      });
      console.log(followedProfiles);

      const followedProfileIds = followedProfiles.map(
        (follow) => follow.profileId,
      );

      const posts = await prisma.post.findMany({
        where: { profileId: { in: followedProfileIds } },
        orderBy: { createdAt: 'desc' },
        include: {
          profile: {
            select: { username: true, profilePicUrl: true },
          },
        },
      });

      return posts;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to follow profile');
    }
  },
};

export default postServices;
