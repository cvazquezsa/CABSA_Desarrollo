[Forma]
Clave=NivelAcademico
Nombre=Niveles Acad�micos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=352
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=321
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NivelAcademico
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NivelAcademico.NivelAcademico
CarpetaVisible=S

[Lista.NivelAcademico.NivelAcademico]
Carpeta=Lista
Clave=NivelAcademico.NivelAcademico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NivelAcademico:NivelAcademico.NivelAcademico)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
NivelAcademico=292
