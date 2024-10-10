import api from './api'; // Assure-toi que tu as bien configuré Axios dans api.js

// Récupérer les périodes de travail d'un utilisateur
export const getWorkingTimesByUserId = (userId) => {
    return api.get(`/workingtime/${userId}`);
};

export const createWorkingTimeAPI = (userId, workingTimeData) => {
    return api.post(`/workingtime/${userId}`, { working_time: workingTimeData });
};

// Mettre à jour une période de travail existante
export const updateWorkingTimeAPI = (workingTimeId, workingTimeData) => {
    return api.put(`/workingtime/${workingTimeId}`, workingTimeData);
};

// Supprimer une période de travail
export const deleteWorkingTimeAPI = (workingTimeId) => {
    return api.delete(`/workingtime/${workingTimeId}`);
};

export const getWorkingTimes = (userId) => {
    return api.get(`/workingtime/${userId}`);
};

export const createWorkingTime = (workingTime) => {
    return api.post(`/workingtime/${workingTime.user_id}`, {
        working_time: {
            start: workingTime.start,
            end: workingTime.end,
            user_id: workingTime.user_id
        }
    });
};