[Forma]
Clave=VentaCampos
Nombre=Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=469
PosicionInicialArriba=97
PosicionInicialAltura=313
PosicionInicialAncho=427
PosicionInicialAlturaCliente=504

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S
ConCondicion=S
EjecucionCondicion=ConDatos(VentaCampos:Venta.Cliente)

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCampos
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
FiltroGeneral=Venta.ID={Info.ID}
[Ficha.Venta.Concepto]
Carpeta=Ficha
Clave=Venta.Concepto
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Venta.Referencia]
Carpeta=Ficha
Clave=Venta.Referencia
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
ValidaNombre=N
3D=S
Tamano=24
ColorFondo=Plata

[Ficha.Venta.Condicion]
Carpeta=Ficha
Clave=Venta.Condicion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Venta.Vencimiento]
Carpeta=Ficha
Clave=Venta.Vencimiento
Editar=S
EditarConBloqueo=S
3D=S
Tamano=19
ColorFondo=Blanco

[Ficha.Venta.Agente]
Carpeta=Ficha
Clave=Venta.Agente
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=15
ColorFondo=Blanco

[Ficha.Venta.Observaciones]
Carpeta=Ficha
Clave=Venta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
EditarConBloqueo=S
EspacioPrevio=N

[Ficha.Venta.Causa]
Carpeta=Ficha
Clave=Venta.Causa
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Venta.FormaEnvio]
Carpeta=Ficha
Clave=Venta.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.OrdenCompra]
Carpeta=Ficha
Clave=Venta.OrdenCompra
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=19
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.EnviarA]
Carpeta=Ficha
Clave=Venta.EnviarA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
EspacioPrevio=N
EditarConBloqueo=S

[Ficha.CteEnviarA.Nombre]
Carpeta=Ficha
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=24
ColorFondo=Plata

[Ficha.Venta.DesglosarImpuestos]
Carpeta=Ficha
Clave=Venta.DesglosarImpuestos
Editar=S
LineaNueva=S
3D=S
Tamano=12
ColorFondo=Blanco
EspacioPrevio=S
EditarConBloqueo=S

[Ficha.Venta.ExcluirPlaneacion]
Carpeta=Ficha
Clave=Venta.ExcluirPlaneacion
Editar=S
LineaNueva=N
3D=S
Tamano=12
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.FechaRequerida]
Carpeta=Ficha
Clave=Venta.FechaRequerida
Editar=S
EditarConBloqueo=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.Venta.Cliente]
Carpeta=Ficha
Clave=Venta.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Cte.Nombre]
Carpeta=Ficha
Clave=Cte.Nombre
Editar=S
3D=S
Tamano=24
ColorFondo=Plata

[Ficha.Venta.FechaEmision]
Carpeta=Ficha
Clave=Venta.FechaEmision
Editar=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
ValidaNombre=S
EditarConBloqueo=S

[Ficha.Venta.ServicioFecha]
Carpeta=Ficha
Clave=Venta.ServicioFecha
Editar=S
3D=S
Tamano=19
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.Clase]
Carpeta=Ficha
Clave=Venta.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.Subclase]
Carpeta=Ficha
Clave=Venta.Subclase
Editar=S
3D=S
Pegado=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.Proyecto]
Carpeta=Ficha
Clave=Venta.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.UEN]
Carpeta=Ficha
Clave=Venta.UEN
Editar=S
ValidaNombre=N
3D=S
Tamano=9
ColorFondo=Blanco
EditarConBloqueo=S

[Ficha.Venta.DesglosarImpuesto2]
Carpeta=Ficha
Clave=Venta.DesglosarImpuesto2
Editar=S
3D=S
Tamano=12
ColorFondo=Blanco
EditarConBloqueo=S




[Ficha.Venta.Almacen]
Carpeta=Ficha
Clave=Venta.Almacen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco







[Ficha.Venta.PosicionWMS]
Carpeta=Ficha
Clave=Venta.PosicionWMS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco




[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=CFD
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaCFDIRelacionado
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General


FiltroGeneral=VentaCFDIRelacionado.ID={Info.ID}
CondicionVisible=(SQL(<T>SELECT SubClave FROM MovTipo WHERE Modulo=:tModulo AND Mov=:tMov<T>, <T>VTAS<T>, VentaCampos:Venta.Mov) = <T>CFDI.COMERCIOEXT<T>) o<BR>(SQL(<T>SELECT TipoComplemento FROM CteCFD WHERE Cliente=:tCliente<T>, VentaCampos:Venta.Cliente) = <T>Comercio Exterior<T>) o<BR>(no Vacio(SQL(<T>SELECT NumRegIdTrib FROM CteCFD WHERE Cliente=:tCliente<T>, VentaCampos:Venta.Cliente)))
CondicionEdicion=SQL(<T>SELECT CFDTimbrado FROM Venta WHERE ID = :nID<T>, VentaCampos:Venta.ID) = 0
[Detalle.VentaCFDIRelacionado.CFDIAplica]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.CFDIAplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=N

[Detalle.VentaCFDIRelacionado.CFDIAplicaID]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.CFDIAplicaID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EditarConBloqueo=N


[Detalle.VentaCFDIRelacionado.Incoterm]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.Incoterm
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.VentaCFDIRelacionado.Subdivision]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.Subdivision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Detalle.SATIncoterm.Descripcion]
Carpeta=Detalle
Clave=SATIncoterm.Descripcion
Editar=S
3D=S
Pegado=S
Tamano=25
ColorFondo=Plata
ColorFuente=Gris

[Detalle.VentaCFDIRelacionado.Destinatario]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.Destinatario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[Detalle.Cte.Nombre]
Carpeta=Detalle
Clave=Cte.Nombre
Editar=S
3D=S
Pegado=S
Tamano=25
ColorFondo=Plata
ColorFuente=Gris





[Ficha.ListaEnCaptura]
(Inicio)=Venta.Proyecto
Venta.Proyecto=Venta.UEN
Venta.UEN=Venta.Concepto
Venta.Concepto=Venta.FechaEmision
Venta.FechaEmision=Venta.ServicioFecha
Venta.ServicioFecha=Venta.Referencia
Venta.Referencia=Venta.OrdenCompra
Venta.OrdenCompra=Venta.Condicion
Venta.Condicion=Venta.Vencimiento
Venta.Vencimiento=Venta.FechaRequerida
Venta.FechaRequerida=Venta.FormaEnvio
Venta.FormaEnvio=Venta.Observaciones
Venta.Observaciones=Venta.Causa
Venta.Causa=Venta.Clase
Venta.Clase=Venta.Subclase
Venta.Subclase=Venta.Cliente
Venta.Cliente=Cte.Nombre
Cte.Nombre=Venta.EnviarA
Venta.EnviarA=CteEnviarA.Nombre
CteEnviarA.Nombre=Venta.Agente
Venta.Agente=Agente.Nombre
Agente.Nombre=Venta.DesglosarImpuestos
Venta.DesglosarImpuestos=Venta.DesglosarImpuesto2
Venta.DesglosarImpuesto2=Venta.ExcluirPlaneacion
Venta.ExcluirPlaneacion=Venta.Almacen
Venta.Almacen=Venta.PosicionWMS
Venta.PosicionWMS=(Fin)






[Detalle.VentaCFDIRelacionado.MotivoTraslado]
Carpeta=Detalle
Clave=VentaCFDIRelacionado.MotivoTraslado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.Columnas]
Clave=31
Descripcion=305


[Detalle.ListaEnCaptura]
(Inicio)=VentaCFDIRelacionado.CFDIAplica
VentaCFDIRelacionado.CFDIAplica=VentaCFDIRelacionado.CFDIAplicaID
VentaCFDIRelacionado.CFDIAplicaID=VentaCFDIRelacionado.MotivoTraslado
VentaCFDIRelacionado.MotivoTraslado=VentaCFDIRelacionado.Incoterm
VentaCFDIRelacionado.Incoterm=SATIncoterm.Descripcion
SATIncoterm.Descripcion=VentaCFDIRelacionado.Subdivision
VentaCFDIRelacionado.Subdivision=VentaCFDIRelacionado.Destinatario
VentaCFDIRelacionado.Destinatario=Cte.Nombre
Cte.Nombre=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Detalle
Detalle=(Fin)
