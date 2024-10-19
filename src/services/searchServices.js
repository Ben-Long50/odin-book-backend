import prisma from '../config/database.js';

const searchServices = {
  searchProfiles: async (query) => {
    try {
      const profiles = await prisma.profile.findMany({
        where: { username: { contains: query, mode: 'insensitive' } },
        select: {
          id: true,
          username: true,
          petName: true,
          profilePicUrl: true,
        },
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

  getSearches: async (activeId) => {
    try {
      const searches = await prisma.search.findMany({
        where: {
          profileId: Number(activeId),
        },

        orderBy: {
          createdAt: 'desc',
        },
        include: {
          searchedProfile: {
            select: {
              id: true,
              username: true,
              petName: true,
              profilePicUrl: true,
            },
          },
        },
      });
      return searches;
    } catch (error) {
      throw new Error('Failed to delete search history');
    }
  },

  createSearch: async (profileId, activeId) => {
    try {
      const oldSearch = await prisma.search.findFirst({
        where: {
          searchedProfileId: Number(profileId),
          profileId: Number(activeId),
        },
      });
      if (oldSearch) {
        await prisma.search.delete({
          where: {
            searchedProfileId: Number(profileId),
            profileId: Number(activeId),
          },
        });
      }
      const newSearch = await prisma.search.create({
        data: {
          searchedProfileId: Number(profileId),
          profileId: Number(activeId),
        },
      });
      return newSearch;
    } catch (error) {
      throw new Error('Failed to create search entry');
    }
  },

  deleteSearch: async (profileId, activeId) => {
    try {
      await prisma.search.delete({
        where: {
          searchId: {
            searchedProfileId: Number(profileId),
            profileId: Number(activeId),
          },
        },
      });
    } catch (error) {
      throw new Error('Failed to delete search entry');
    }
  },

  deleteAllSearches: async (activeId) => {
    try {
      await prisma.search.deleteMany({
        where: {
          profileId: Number(activeId),
        },
      });
    } catch (error) {
      throw new Error('Failed to delete search history');
    }
  },
};

export default searchServices;
