package model;

import java.util.ArrayList;

public class TermoCompostoStats {

	/**
	 * String contendo o termo
	 */
	public String termo;
	/**
	 * Os tokens que fazem parte do termo
	 */
	public ArrayList<Token> tokens = new ArrayList<Token>();
	/**
	 * As tags já utilizadas na marcação do termos
	 */
	public ArrayList<Tag> tags = new ArrayList<Tag>();
	/**
	 * As porcentagens no uso de cada tag
	 */
	public ArrayList<Double> percents = new ArrayList<Double>();
	
}