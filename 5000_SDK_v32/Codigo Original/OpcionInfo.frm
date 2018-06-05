[Forma]
Clave=OpcionInfo
Nombre=Opciones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=201
PosicionInicialArriba=240
PosicionInicialAltura=287
PosicionInicialAncho=622
VentanaTipoMarco=Chico (Variable)
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=53

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Opcion
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
ListaEnCaptura=(Lista)
OtroOrden=S
ListaOrden=Opcion.Opcion<TAB>(Acendente)
HojaMantenerSeleccion=S
HojaSinBorde=S

[Lista.Opcion.Opcion]
Carpeta=Lista
Clave=Opcion.Opcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=1
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Opcion.Descripcion]
Carpeta=Lista
Clave=Opcion.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Opcion=38
Descripcion=259
TieneDetalle=45

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Listas]
Nombre=Listas
Boton=57
NombreEnBoton=S
NombreDesplegar=&Listas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=OpcionListaInfo
Visible=S
ConCondicion=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
ActivoCondicion=Opcion:Opcion.TieneDetalle
EjecucionCondicion=ConDatos(Opcion:Opcion.Opcion)
AntesExpresiones=Asigna(Info.Opcion, Opcion:Opcion.Opcion)<BR>Asigna(Info.Descripcion, Opcion:Opcion.Descripcion)

[Detalle]
Estilo=Hoja
Clave=Detalle
Detalle=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=OpcionD
Fuente={MS Sans Serif, 8, Negro, []}
VistaMaestra=Opcion
LlaveLocal=OpcionD.Opcion
LlaveMaestra=Opcion.Opcion
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
HojaSinBorde=S
MenuLocal=S
ListaAcciones=Anexos

[Detalle.OpcionD.Numero]
Carpeta=Detalle
Clave=OpcionD.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.OpcionD.Nombre]
Carpeta=Detalle
Clave=OpcionD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Columnas]
Numero=46
Nombre=215

[Acciones.Anexos]
Nombre=Anexos
Boton=0
NombreDesplegar=&Anexos
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
ConCondicion=S
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=F4
EjecucionCondicion=ConDatos(OpcionD:OpcionD.Numero)
AntesExpresiones=Asigna(Info.Rama, <T>OPC<T>)<BR>Asigna(Info.AnexoCfg, Falso)<BR>Asigna(Info.Cuenta, OpcionD:OpcionD.Opcion+OpcionD:OpcionD.Numero)<BR>Asigna(Info.Descripcion, OpcionD:OpcionD.Nombre)
RefrescarDespues=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Listas
Listas=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Opcion.Opcion
Opcion.Opcion=Opcion.Descripcion
Opcion.Descripcion=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=OpcionD.Numero
OpcionD.Numero=OpcionD.Nombre
OpcionD.Nombre=(Fin)
