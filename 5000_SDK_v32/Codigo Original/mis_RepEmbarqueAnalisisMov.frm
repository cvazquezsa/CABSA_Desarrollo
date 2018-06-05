[Forma]
Clave=mis_RepEmbarqueAnalisisMov
Nombre=General de Movimientos   ( Embarques )
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
PosicionInicialAltura=348
PosicionInicialAncho=508
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=546
PosicionInicialArriba=270
SinCondicionDespliege=S
MovModulo=EMB
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=292

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.AgenteD, SQL(<T>SELECT Min(Agente) FROM Agente<T>))<BR>Asigna(Info.AgenteA, SQL(<T>SELECT Max(Agente) FROM Agente<T>))<BR>Asigna(Info.ClienteD, SQL(<T>SELECT Min(Cliente) FROM Cte<T>))<BR>Asigna(Info.ClienteA, SQL(<T>SELECT Max(Cliente) FROM Cte<T>))<BR>Asigna(Info.CteCat, <T>(Todos)<T>)<BR>Asigna(Info.CteFam, <T>(Todos)<T>)<BR>Asigna(Info.CteGrupo, <T>(Todos)<T>)<BR>Asigna(Info.MovClaveAfecta, <T><T>)<BR>Asigna(Info.Modulo, <T>EMB<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Estatus, <T>Concluido<T>)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Desglosar, <T>No<T>)<BR>Asigna(Info.DesgloseArticulos, <T>No<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioEntreLineas=7
FichaEspacioNombres=105
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Blanco
FichaAlineacionDerecha=S
FichaEspacioNombresAuto=S
PermiteEditar=S

[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=S

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.Estatus]
Carpeta=(Variables)
Clave=Info.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=N

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.AgenteD]
Carpeta=(Variables)
Clave=Info.AgenteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.AgenteA]
Carpeta=(Variables)
Clave=Info.AgenteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ClienteD]
Carpeta=(Variables)
Clave=Info.ClienteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.ClienteA]
Carpeta=(Variables)
Clave=Info.ClienteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteCat]
Carpeta=(Variables)
Clave=Info.CteCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteGrupo]
Carpeta=(Variables)
Clave=Info.CteGrupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.CteFam]
Carpeta=(Variables)
Clave=Info.CteFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.Imprimir.mis_EmbarqueAnalisisMov]
Nombre=mis_EmbarqueAnalisisMov
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_EmbarqueAnalisisMov

[Acciones.Preliminar.mis_EmbarqueAnalisisMov]
Nombre=mis_EmbarqueAnalisisMov
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_EmbarqueAnalisisMov

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).Info.MovClaveAfecta]
Carpeta=(Variables)
Clave=Info.MovClaveAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Acciones.Imprimir.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=mis_EmbarqueAnalisisMov
mis_EmbarqueAnalisisMov=(Fin)


[Acciones.Preliminar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=mis_EmbarqueAnalisisMov
mis_EmbarqueAnalisisMov=(Fin)


[(Variables).ListaEnCaptura]
(Inicio)=Info.AgenteD
Info.AgenteD=Info.AgenteA
Info.AgenteA=Info.ClienteD
Info.ClienteD=Info.ClienteA
Info.ClienteA=Info.CteCat
Info.CteCat=Info.CteGrupo
Info.CteGrupo=Info.CteFam
Info.CteFam=Info.Sucursal
Info.Sucursal=Info.UEN
Info.UEN=Info.MovClaveAfecta
Info.MovClaveAfecta=Info.Estatus
Info.Estatus=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Desglosar
Info.Desglosar=Info.DesgloseArticulos
Info.DesgloseArticulos=(Fin)

[(Variables).Info.DesgloseArticulos]
Carpeta=(Variables)
Clave=Info.DesgloseArticulos
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
