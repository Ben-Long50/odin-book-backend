import prisma from '../config/database.js';

const profileServices = {
  getProfiles: async (userId) => {
    try {
      const profiles = await prisma.profile.findMany({
        where: { userId },
        orderBy: {
          username: 'asc',
        },
      });
      return profiles;
    } catch (error) {
      throw new Error('Failed to fetch profiles');
    }
  },

  createOrUpdateProfile: async (profileData, userId) => {
    try {
      const { id, imageURL, username, petName, bio, species, breed } =
        profileData;

      if (id !== 'null') {
        return await prisma.profile.update({
          where: { id: Number(id) },
          data: {
            profilePicUrl: imageURL,
            username,
            petName,
            bio,
            species,
            breed,
          },
        });
      }
      return await prisma.profile.create({
        data: {
          username,
          profilePicUrl: imageURL,
          petName,
          bio,
          species,
          breed,
          active: false,
          userId,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to update or create a profile');
    }
  },

  getActiveProfile: async (userId) => {
    try {
      return await prisma.profile.findFirst({
        where: { userId, active: true },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to find active profile');
    }
  },

  setActiveProfile: async (userId, profileId) => {
    try {
      const currentActiveProfile = await prisma.profile.findFirst({
        where: { userId, active: true },
      });
      if (currentActiveProfile) {
        await prisma.profile.update({
          where: { id: currentActiveProfile.id },
          data: { active: false },
        });
      }
      return await prisma.profile.update({
        where: { id: profileId },
        data: { active: true },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to update active profile');
    }
  },

  deleteProfile: async (profileId) => {
    try {
      await prisma.profile.delete({
        where: { id: Number(profileId) },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to delete profile');
    }
  },

  getFollows: async (profileId) => {
    try {
      const followers = await prisma.follow.findMany({
        where: { profileId: Number(profileId) },
      });
      const following = await prisma.follow.findMany({
        where: { followerId: Number(profileId) },
      });
      return { followers, following };
    } catch (error) {
      console.error(error);
      throw new Error('Failed to find followers');
    }
  },

  followProfile: async (activeId, profileId) => {
    try {
      await prisma.follow.create({
        data: { profileId: Number(profileId), followerId: Number(activeId) },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to follow profile');
    }
  },

  unfollowProfile: async (activeId, profileId) => {
    try {
      await prisma.follow.delete({
        where: {
          followId: {
            profileId: Number(profileId),
            followerId: Number(activeId),
          },
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error('Failed to unfollow profile');
    }
  },

  getPosts: async (profileId) => {
    try {
      const posts = await prisma.post.findMany({
        where: { profileId: Number(profileId) },
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
      throw new Error('Failed to follow profile');
    }
  },

  createPost: async (postData, profileId) => {
    try {
      const { imageURL, caption } = postData;
      const post = await prisma.post.create({
        data: {
          mediaUrl: imageURL,
          body: caption,
          profileId: Number(profileId),
        },
      });
      return post;
    } catch (error) {
      console.error(error);
      throw new Error('Failed to create post');
    }
  },
};

export default profileServices;
