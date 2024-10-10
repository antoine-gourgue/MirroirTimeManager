import api from './api';

export const getUsers = () => {
    return api.get('/users');
};

export const getUserById = (userId) => {
    return api.get(`/users/${userId}`);
};

export const createUser = (userData) => {
    return api.post('/users', { user: userData });
};

export const updateUser = (userId, userData) => {
    return api.put(`/users/${userId}`, { user: userData });
};

export const deleteUser = (userId) => {
    return api.delete(`/users/${userId}`);
};

export const getUserByEmailAndUsername = (email, username) => {
    return api.get(`/users`, { params: { email, username } });
};

