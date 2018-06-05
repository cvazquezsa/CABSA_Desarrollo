[Forma]
Clave=ZonaEconomica
Nombre=Zonas Economicas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=390
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=244
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ZonaEconomica
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
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

[Lista.ZonaEconomica.Zona]
Carpeta=Lista
Clave=ZonaEconomica.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ZonaEconomica.SueldoMinimo]
Carpeta=Lista
Clave=ZonaEconomica.SueldoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Zona=136
SueldoMinimo=78

[Acciones.Historico]
Nombre=Historico
Boton=53
NombreEnBoton=S
NombreDesplegar=&Histórico
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ZonaEconomicaHist
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ZonaEconomica:ZonaEconomica.Zona)
AntesExpresiones=Asigna(Info.Zona, ZonaEconomica:ZonaEconomica.Zona)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Historico
Historico=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ZonaEconomica.Zona
ZonaEconomica.Zona=ZonaEconomica.SueldoMinimo
ZonaEconomica.SueldoMinimo=(Fin)
