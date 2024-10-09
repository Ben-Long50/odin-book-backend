import express from 'express';
import searchController from '../controllers/searchController.js';

const router = express.Router();

router.get('/search/:query', searchController.searchProfiles);

export default router;
