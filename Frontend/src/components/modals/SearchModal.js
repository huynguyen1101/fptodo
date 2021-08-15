import React, { useEffect } from 'react';
import { v4 as uuidv4 } from 'uuid';
import { modalBlurHandler } from '../../static/js/util';
import useAxiosGet from '../../hooks/useAxiosGet'

import Card from '../boards/Card';
import SearchedBoard from '../boards/SearchedBoard';
import SearchedCard from '../boards/SearchedCard';
import { backendUrl } from "../../static/js/const";
import axios from "axios";

const getSearchSuggestionsPosition = (searchElem) => {
	if (!searchElem) return null;
	return {
		top: searchElem.getBoundingClientRect().y + searchElem.getBoundingClientRect().height + 10 + "px",
		left: searchElem.getBoundingClientRect().x + "px"
	}
}

const SearchModal = ({ backendQuery, searchElem, setShowModal }) => {

	// const {data:cards} = useAxiosGet(`/boards/items/?q=${backendQuery}`)
	// const { data } = await axios.get(backendUrl + `/boards/?q=${backendQuery}`)
	const { data: boards } = useAxiosGet(`/boards/?q=${backendQuery}`);
	const { data: lists } = useAxiosGet(`/boards/lists/?title=${backendQuery}`)

	useEffect(modalBlurHandler(setShowModal), []);


	return (
		<div className="search-suggestions" style={getSearchSuggestionsPosition(searchElem.current)}>
			<div>
				<p className="search-suggestions__title">List</p>
				<ul className="search-suggestions__cards">
					{(lists || []).map(list => (
						<SearchedCard list={list} setShowModal={setShowModal} key={uuidv4()} />
					))}
				</ul>
			</div>
			<div>
				<p className="search-suggestions__title">Boards</p>
				<ul className="search-suggestions__boards">
					{(boards || []).map(board => (
						<SearchedBoard board={board} setShowModal={setShowModal} key={uuidv4()} />
					))}
				</ul>
			</div>
		</div>
	);
}

export default SearchModal;