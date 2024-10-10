import api from './api';

export const clockInAPI = (userId) => {
    return api.post(`/clocks/${userId}`, {
        clock: {
            status: true,
            time: new Date().toISOString(),
        },
    });
};

export const clockOutAPI = (userId) => {
    return api.post(`/clocks/${userId}`, {
        clock: {
            status: false,
            time: new Date().toISOString(),
        },
    });
};

export const getCurrentClockStatusAPI = (userId) => {
    return api.get(`/clocks/${userId}`);
};
