SELECT a.ID, a.Empresa, d.ConceptoFE,a.Mov, a.MovID, a.Moneda, a.Cuenta, a.Fecha, a.Cargo, a.Abono, a.EsCancelacion 
	FROM Auxiliar a 
		JOIN Dinero d ON a.ModuloID = d.ID AND a.Modulo = 'DIN'
		JOIN MovTipo mt ON a.Modulo = mt.Modulo AND a.Mov = mt.Mov
	WHERE a.Rama = 'DIN'