
[Forma]
Clave=CfgLista
Icono=0
Modulos=(Todos)
Nombre=Listas - Configuración

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=512
PosicionInicialArriba=165
PosicionInicialAlturaCliente=402
PosicionInicialAncho=341
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgLista
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CfgLista.Lista
CarpetaVisible=S

[Lista.CfgLista.Lista]
Carpeta=Lista
Clave=CfgLista.Lista
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

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
Lista=304

[Acciones.Lista]
Nombre=Lista
Boton=47
NombreEnBoton=S
NombreDesplegar=<T>&Lista<T>
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CfgListaD
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CfgLista:CfgLista.Lista)
Antes=S
AntesExpresiones=Asigna(Info.Lista, CfgLista:CfgLista.Lista)
Visible=S

























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Lista
Lista=(Fin)
