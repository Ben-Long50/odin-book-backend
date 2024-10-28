import prisma from '../config/database.js';

const userServices = {
  getAllUsers: async () => {
    try {
      const users = await prisma.user.findMany();
      return users;
    } catch (error) {
      throw new Error('Failed to fetch users');
    }
  },

  getUserByEmail: async (email) => {
    try {
      const user = await prisma.user.findUnique({
        where: { email },
      });
      return user;
    } catch (error) {
      throw new Error('Failed to fetch user');
    }
  },

  getUserById: async (userId) => {
    try {
      const user = await prisma.user.findUnique({
        where: { id: Number(userId) },
      });
      return user;
    } catch (error) {
      throw new Error('Failed to fetch user');
    }
  },

  deleteUserById: async (userId) => {
    try {
      const user = await prisma.user.delete({
        where: { id: Number(userId) },
      });
      return user;
    } catch (error) {
      throw new Error('Failed to delete user');
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
          role: 'USER',
        },
      });
      return newUser;
    } catch (error) {
      throw new Error('Failed to create user');
    }
  },

  createGuestUser: async (guestData) => {
    try {
      const newUser = await prisma.user.create({
        data: {
          firstName: guestData.firstName,
          lastName: guestData.lastName,
          email: guestData.email,
          password: guestData.password,
          role: 'GUEST',
        },
      });
      return newUser;
    } catch (error) {
      throw new Error('Failed to create user');
    }
  },
};

export default userServices;
