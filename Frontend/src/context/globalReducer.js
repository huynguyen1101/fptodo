export const LOGIN = "LOGIN";
export const LOGOUT = "LOGOUT";
export const SET_BOARD_CONTEXT = "SET_BOARD_CONTEXT";

export const globalReducer = (state, action) => {
    action.user = {
        "id": action?.user?.id ? action?.user?.id : null,
        "username": action?.user?.username ? action?.user?.username : "",
        "email": action?.user?.email ? action?.user?.email : "",
        "first_name": action?.user?.first_name ? action?.user?.first_name : "",
        "last_name": action?.user?.last_name ? action?.user?.last_name : "",
        "full_name": action?.user?.full_name ? action?.user?.full_name : "",
        "profile_pic": action?.user?.profile_pic ? action?.user?.profile_pic : null,
        "city": action?.user?.city ? action?.user?.city : "",
        "country": action?.user?.country ? action?.user?.country : "",
        "about_me": action?.user?.about_me ? action?.user?.about_me : "",
    }
    switch (action.type) {
        case LOGIN:
            return { ...state, authUser: action.user, checkedAuth: true };
        case LOGOUT:
            return { ...state, authUser: null, checkedAuth: true };
        case SET_BOARD_CONTEXT:
            return { ...state, board: action.board, setBoard: action.setBoard };
        default:
            return state;
    }
};
