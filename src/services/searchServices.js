import prisma from '../config/database.js';

const searchServices = {
  searchProfiles: async (query) => {
    try {
      const profiles = await prisma.profile.findMany({
        where: { username: { contains: query, mode: 'insensitive' } },
        orderBy: {
          username: 'asc',
        },
        take: 20,
      });
      return profiles;
    } catch (error) {
      throw new Error('Failed to fetch profiles');
    }
  },
};

export default searchServices;
