package model;

public class TextoStatus {
	
	/**
	 * Em processo de REVISÃO DE TEXTO
	 */
	public static final String REVISAO = "I";
	
	/**
	 * Em processo de ANOTAÇÃO - Revisão finalizada
	 */
	public static final String ANOTACAO = "R";
	
	/**
	 * Em processo de ADJUDICAÇÃO - Anotação finalizada
	 */
	public static final String ADJUDICACAO = "A";
	
	/**
	 * Finalizados todos processos
	 */
	public static final String FINALIZADO = "F";

}
