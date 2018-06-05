[Forma]
Clave=TablaNum
Nombre=Tablas Numéricas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=756
PosicionInicialArriba=411
PosicionInicialAltura=300
PosicionInicialAncho=416
PosicionInicialAlturaCliente=342

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TablaNum
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TablaNum.TablaNum
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.TablaNum.TablaNum]
Carpeta=Lista
Clave=TablaNum.TablaNum
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
TablaNum=379

[Acciones.Tabla]
Nombre=Tabla
Boton=47
NombreEnBoton=S
NombreDesplegar=E&ditar Tabla
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=TablaNumD
Activo=S
Visible=S
Antes=S
ConCondicion=S
EjecucionCondicion=ConDatos(TablaNum:TablaNum.TablaNum)
AntesExpresiones=Asigna(Info.Tabla,TablaNum:TablaNum.TablaNum)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Tabla
Tabla=(Fin)
