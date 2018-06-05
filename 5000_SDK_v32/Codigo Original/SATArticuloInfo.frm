
[Forma]
Clave=SATArticuloInfo
Icono=0
Modulos=(Todos)
Nombre=<T>Información de Artículos<T>
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=306
PosicionInicialArriba=116
PosicionInicialAlturaCliente=465
PosicionInicialAncho=747
ListaAcciones=(Lista)
[Lista]
Estilo=Hoja
Clave=Lista
ValidarCampos=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SATArticuloInfo
Fuente={Tahoma, 8, Negro, []}
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

ListaCamposAValidar=Art.Descripcion1
CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=SATArticuloInfo.Articulo
SATArticuloInfo.Articulo=SATArticuloInfo.FraccionArancelaria
SATArticuloInfo.FraccionArancelaria=SATArticuloInfo.Marca
SATArticuloInfo.Marca=SATArticuloInfo.Modelo
SATArticuloInfo.Modelo=SATArticuloInfo.SubModelo
SATArticuloInfo.SubModelo=(Fin)

[Lista.SATArticuloInfo.Articulo]
Carpeta=Lista
Clave=SATArticuloInfo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATArticuloInfo.FraccionArancelaria]
Carpeta=Lista
Clave=SATArticuloInfo.FraccionArancelaria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.SATArticuloInfo.Marca]
Carpeta=Lista
Clave=SATArticuloInfo.Marca
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATArticuloInfo.Modelo]
Carpeta=Lista
Clave=SATArticuloInfo.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.SATArticuloInfo.SubModelo]
Carpeta=Lista
Clave=SATArticuloInfo.SubModelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Columnas]
Articulo=124
FraccionArancelaria=118
Marca=144
Modelo=145
SubModelo=159

Descripcion1=244
Clave=97
Descripcion=506
UnidadMedida=95
Importacion=64
Exportacion=64
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=&Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S





















[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
