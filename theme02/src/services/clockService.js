import api from './api'; // Assure-toi que le fichier api.js est configuré avec Axios

// Marquer le début de travail (clock-in)
export const clockInAPI = (userId) => {
    return api.post(`/clocks/${userId}`, {
        clock: {
            status: true,
            time: new Date().toISOString(), // L'heure actuelle en format ISO
        },
    });
};

// Marquer la fin de travail (clock-out)
export const clockOutAPI = (userId) => {
    return api.post(`/clocks/${userId}`, {
        clock: {
            status: false,
            time: new Date().toISOString(),
        },
    });
};

// Obtenir l'état actuel de l'horloge pour l'utilisateur
export const getCurrentClockStatusAPI = (userId) => {
    return api.get(`/clocks/${userId}`);
};
