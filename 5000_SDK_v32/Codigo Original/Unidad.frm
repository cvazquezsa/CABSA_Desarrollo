[Forma]
Clave=Unidad
Nombre=Unidades
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
PosicionInicialIzquierda=411
PosicionInicialArriba=144
PosicionInicialAltura=303
PosicionInicialAncho=543
PosicionInicialAlturaCliente=401

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Unidad
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
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=(Lista)

[Lista.Unidad.Unidad]
Carpeta=Lista
Clave=Unidad.Unidad
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
ConCondicion=S
EjecucionConError=S

EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Unidad:Unidad.Unidad)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
[Lista.Columnas]
Unidad=151
Factor=76
Decimales=93
Orden=37
Multiplo=54
AutoAjuste=158
Clave=49
ReferenciaIntelisisService=133
INFORDescripcion=184

Descripcion=234
[Acciones.Conversiones]
Nombre=Conversiones
Boton=10
NombreEnBoton=S
NombreDesplegar=&Conversiones Válidas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UnidadConversion
Activo=S
EspacioPrevio=S
GuardarAntes=S
Visible=S

[Lista.Unidad.Factor]
Carpeta=Lista
Clave=Unidad.Factor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Unidad.Decimales]
Carpeta=Lista
Clave=Unidad.Decimales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>UnidadOrdenar<T>)

[Lista.Unidad.AutoAjuste]
Carpeta=Lista
Clave=Unidad.AutoAjuste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Unidad.Clave]
Carpeta=Lista
Clave=Unidad.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco






[Lista.ListaEnCaptura]
(Inicio)=Unidad.Unidad
Unidad.Unidad=Unidad.Clave
Unidad.Clave=Unidad.Factor
Unidad.Factor=Unidad.Decimales
Unidad.Decimales=Unidad.AutoAjuste
Unidad.AutoAjuste=(Fin)

[Lista.ListaOrden]
(Inicio)=Unidad.Orden	(Acendente)
Unidad.Orden	(Acendente)=Unidad.Unidad	(Acendente)
Unidad.Unidad	(Acendente)=(Fin)





















































[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ordenar
Ordenar=Conversiones
Conversiones=(Fin)
