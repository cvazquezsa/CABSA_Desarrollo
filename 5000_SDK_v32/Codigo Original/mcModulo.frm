[Forma]
Clave=mcModulo
Nombre=Módulos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=614
PosicionInicialArriba=319
PosicionInicialAlturaCliente=525
PosicionInicialAncho=692
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=MC.TablaGet(<T>mcCampo<T>)<BR>MC.TablaGet(<T>mcMayor<T>)<BR>MC.TablaGet(<T>mcModulo<T>)<BR>MC.TablaGet(<T>mcModuloCampo<T>)<BR>MC.TablaGet(<T>mcModuloCampoProp<T>)<BR>MC.TablaGet(<T>mcModuloMov<T>)<BR>MC.TablaGet(<T>mcModuloMovPoliza<T>)<BR>MC.TablaGet(<T>mcBandera<T>)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcModulo
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
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.mcModulo.Modulo]
Carpeta=Lista
Clave=mcModulo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModulo.Ruta]
Carpeta=Lista
Clave=mcModulo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
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
Antes=S
DespuesGuardar=S
AntesExpresiones=MC.TablaPost(<T>mcModulo<T>)<BR>MC.TablaPost(<T>mcModuloCampo<T>)<BR>MC.TablaPost(<T>mcModuloCampoProp<T>)<BR>MC.TablaPost(<T>mcModuloMov<T>)<BR>MC.TablaPost(<T>mcModuloMovPoliza<T>)

[Lista.Columnas]
Modulo=50
Ruta=604

[Acciones.Movimientos]
Nombre=Movimientos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Movimientos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=mcModuloMov
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(mcModulo:mcModulo.Modulo)
AntesExpresiones=Asigna(Info.Modulo, mcModulo:mcModulo.Modulo)

[Acciones.Campos]
Nombre=Campos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Campos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=mcModuloCampo
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(mcModulo:mcModulo.Modulo)
AntesExpresiones=Asigna(Info.Modulo, mcModulo:mcModulo.Modulo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Campos
Campos=Movimientos
Movimientos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcModulo.Modulo
mcModulo.Modulo=mcModulo.Ruta
mcModulo.Ruta=(Fin)
