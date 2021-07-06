import React from "react";
import { Link } from "react-router-dom";
import useDocumentTitle from "../hooks/useDocumentTitle";

import bgImage from "../static/img/bgr1.jpg";

const Landing = () => {
    useDocumentTitle("FPTODO");
    return (
        <div className="landing-banner">
            <img className="landing-banner__image" src={bgImage} />
            <div className="landing-banner__content">
                <h1 className="landing-banner__title">
                     FPTodo lets you follow your work, Control your time.
                </h1>
                <h4 className="landing-banner__subtitle">
                        Follow your work and plan out your tasks.
                </h4>
                <Link to="/register" className="btn">
                    Sign Up For Free
                </Link>
            </div>
        </div>
    );
};

export default Landing;
