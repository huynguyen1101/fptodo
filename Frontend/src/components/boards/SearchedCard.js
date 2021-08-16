import React from "react";
import { Link } from "react-router-dom";

const SearchedCard = ({ list, setShowModal }) => {
    return <Link onClick={() => setShowModal(false)} to={`/b/${list.board}`} class="searched-board searched-board--red">
        <p>{list.title}</p>
    </Link>
}

export default SearchedCard;