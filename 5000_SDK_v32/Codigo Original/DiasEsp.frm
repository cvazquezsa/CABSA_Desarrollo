[Forma]
Clave=DiasEsp
Nombre=D�as Espec�ficos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=777
PosicionInicialArriba=390
PosicionInicialAlturaCliente=392
PosicionInicialAncho=366
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DiasEsp
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Autom�tica
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=DiasEsp.DiasEsp
CarpetaVisible=S

[Lista.DiasEsp.DiasEsp]
Carpeta=Lista
Clave=DiasEsp.DiasEsp
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

[Lista.Columnas]
DiasEsp=338

[Acciones.Dias]
Nombre=Dias
Boton=47
NombreEnBoton=S
NombreDesplegar=&D�as
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=DiasEspD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(DiasEsp:DiasEsp.DiasEsp)
Antes=S
AntesExpresiones=Asigna(Info.Nombre, DiasEsp:DiasEsp.DiasEsp)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Dias
Dias=(Fin)
