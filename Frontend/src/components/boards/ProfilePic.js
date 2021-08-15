import React, { useEffect } from "react";

const hashName = (str) => {
    let res = 0;
    for (let i = 0; i < str.length; i++) {
        res += str.charCodeAt(i);
    }

    return res + 1; // So my name maps to blue
};

const colors = ["red", "yellow", "blue"];

const getNameColor = (name) => {
    return colors[hashName(name) % colors.length];
};

const ProfilePic = (props) => {
    return props?.user.profile_pic ? (
        <div className={`member member--image${props?.large ? " member--large" : ""}`}>
            <img src={props?.user.profile_pic} />
        </div>
    ) : (
        <div
            className={`member member--${getNameColor(props?.user.full_name)}${props?.large ? " member--large" : ""
                }`}
        >
            {props?.user.full_name.substring(0, 1)}
        </div>
    );
}

export default ProfilePic;
