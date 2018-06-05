
[Forma]
Clave=ProspectoCompetenciaLista
Icono=0
Modulos=(Todos)
Nombre=Productos a Evaluar

ListaCarpetas=ProspectoCompetenciaLista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
ListaAcciones=(Lista)
CarpetaPrincipal=ProspectoCompetenciaLista
PosicionInicialIzquierda=490
PosicionInicialArriba=191
PosicionInicialAlturaCliente=384
PosicionInicialAncho=363
[ProspectoCompetenciaLista]
Estilo=Hoja
Clave=ProspectoCompetenciaLista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProspectoCompetencia
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[ProspectoCompetenciaLista.ProspectoCompetencia.Descripcion]
Carpeta=ProspectoCompetenciaLista
Clave=ProspectoCompetencia.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S


[ProspectoCompetenciaLista.Columnas]
Descripcion=269






Competencia=64
[ProspectoCompetenciaLista.ListaEnCaptura]
(Inicio)=ProspectoCompetencia.Competencia
ProspectoCompetencia.Competencia=ProspectoCompetencia.Descripcion
ProspectoCompetencia.Descripcion=(Fin)

[ProspectoCompetenciaLista.ProspectoCompetencia.Competencia]
Carpeta=ProspectoCompetenciaLista
Clave=ProspectoCompetencia.Competencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro



[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Cancelar
Cancelar=(Fin)
