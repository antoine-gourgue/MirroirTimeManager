import api from './api';

// Récupérer tous les utilisateurs
export const getUsers = () => {
    return api.get('/users');
};

// Récupérer un utilisateur par ID
export const getUserById = (userId) => {
    return api.get(`/users/${userId}`);
};

// Créer un utilisateur
export const createUser = (userData) => {
    return api.post('/users', { user: userData });
};

// Mettre à jour un utilisateur
export const updateUser = (userId, userData) => {
    return api.put(`/users/${userId}`, { user: userData });
};

// Supprimer un utilisateur
export const deleteUser = (userId) => {
    return api.delete(`/users/${userId}`);
};

// Récupérer un utilisateur par email et username
export const getUserByEmailAndUsername = (email, username) => {
    return api.get(`/users`, { params: { email, username } });
};

