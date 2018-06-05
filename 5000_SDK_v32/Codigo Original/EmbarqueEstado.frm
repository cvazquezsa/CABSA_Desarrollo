[Forma]
Clave=EmbarqueEstado
Nombre=Estados - Embarques
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=356
PosicionInicialArriba=208
PosicionInicialAltura=345
PosicionInicialAncho=312
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=318

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmbarqueEstado
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.EmbarqueEstado.Estado]
Carpeta=Lista
Clave=EmbarqueEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmbarqueEstado.Tipo]
Carpeta=Lista
Clave=EmbarqueEstado.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Estado=191
Tipo=91
Orden=41

[Acciones.Orden]
Nombre=Orden
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
AntesExpresiones=Forma(<T>EmbarqueEstadoOrdenar<T>)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Orden
Orden=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EmbarqueEstado.Estado
EmbarqueEstado.Estado=EmbarqueEstado.Tipo
EmbarqueEstado.Tipo=(Fin)

[Lista.ListaOrden]
(Inicio)=EmbarqueEstado.Orden<TAB>(Acendente)
EmbarqueEstado.Orden<TAB>(Acendente)=EmbarqueEstado.Estado<TAB>(Acendente)
EmbarqueEstado.Estado<TAB>(Acendente)=(Fin)
