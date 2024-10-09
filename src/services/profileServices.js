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
      const { id, username, petName, bio, species, breed } = profileData;

      if (id !== null) {
        return await prisma.profile.update({
          where: { id },
          data: { username, petName, bio, species, breed },
        });
      }
      return await prisma.profile.create({
        data: { username, petName, bio, species, breed, active: false, userId },
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
};

export default profileServices;
