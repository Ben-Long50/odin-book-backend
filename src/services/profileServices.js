import prisma from '../config/database.js';

const profileServices = {
  getProfiles: async (userId) => {
    try {
      const profiles = await prisma.profile.findMany({
        where: { id: userId },
      });
      return profiles;
    } catch (error) {
      throw new Error('Failed to fetch profiles');
    }
  },

  createProfile: async (profileData, userId) => {
    try {
      const { id, username, petName, bio, species, breed } = profileData;

      const profile = await prisma.profile.upsert({
        create: {
          username,
          petName,
          bio,
          species,
          breed,
          active: false,
          userId,
        },
        update: {
          username,
          petName,
          bio,
          species,
          breed,
          active: false,
          userId,
        },
        where: { id },
      });
      return profile;
    } catch (error) {
      throw new Error('Failed to update or create a profile');
    }
  },

  updateActiveProfile: async (userId, profileId) => {
    try {
      const oldActiveProfile = await prisma.profile.update({
        where: { userId: Number(userId), active: true },
        data: { active: false },
      });
      const newActiveProfile = await prisma.profile.update({
        where: { id: profileId },
        data: { active: true },
      });
      return newActiveProfile;
    } catch (error) {
      throw new Error('Failed to fetch profile');
    }
  },

  createUser: async (userData) => {
    try {
      const newUser = await prisma.user.create({
        data: {
          googleId: userData.googleId,
          facebookId: userData.facebookId,
          firstName: userData.firstName,
          lastName: userData.lastName,
          email: userData.email,
          password: userData.password,
        },
      });
      return newUser;
    } catch (error) {
      throw new Error('Failed to create user');
    }
  },
};

export default profileServices;
