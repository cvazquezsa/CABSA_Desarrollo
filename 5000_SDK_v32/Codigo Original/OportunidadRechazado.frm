
[Forma]
Clave=OportunidadRechazado
Icono=4
Modulos=(Todos)
MovModulo=OPORT
Nombre=Rechazado
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
AccionesTamanoBoton=15x5
BarraAcciones=S

ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=519
PosicionInicialArriba=279
PosicionInicialAlturaCliente=132
PosicionInicialAncho=327
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaExclusiva=S
VentanaExclusivaOpcion=0
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata

[(Variables).Info.OPORTMotivo]
Carpeta=(Variables)
Clave=Info.OPORTMotivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[(Variables).Info.OPORTCompetidor]
Carpeta=(Variables)
Clave=Info.OPORTCompetidor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco




[Acciones.Aceptar]
Nombre=Aceptar
Boton=0
EnBarraAcciones=S
Activo=S
Visible=S

NombreDesplegar=Aceptar
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
[Acciones.Cancelar]
Nombre=Cancelar
Boton=0
EnBarraAcciones=S
Activo=S
Visible=S








NombreDesplegar=Cancelar
TipoAccion=Ventana
ClaveAccion=Cancelar
[Lista.Columnas]
Motivo=239

[(Variables).ListaEnCaptura]
(Inicio)=Info.OPORTMotivo
Info.OPORTMotivo=Info.OPORTCompetidor
Info.OPORTCompetidor=(Fin)




































[Competidor.Columnas]
Competidor=304









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
