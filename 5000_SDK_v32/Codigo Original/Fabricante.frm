[Forma]
Clave=Fabricante
Nombre=Fabricantes
Icono=0
Modulos=INV
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=(Lista)
PosicionInicialIzquierda=369
PosicionInicialArriba=325
PosicionInicialAltura=366
PosicionInicialAncho=546
CarpetaPrincipal=Detalle
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionColumna1=40
PosicionInicialAlturaCliente=343

VentanaEstadoInicial=Normal
VentanaColor=Plata
ExpresionesAlMostrar=Asigna(Pos.AgenteDetalle,sql(<T>SELECT POSAgenteDetalle FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))<BR>Asigna(Pos.AgenteDetMaestro,sql(<T>SELECT POSAgenteDetMaestro FROM POSCfg WHERE Empresa = :tEmpresa<T>, Empresa))
[Fabricante.Columnas]
Fabricante=109
Nombre=304

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fabricante
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Fabricante
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.Fabricante.Fabricante]
Carpeta=Detalle
Clave=Fabricante.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Detalle.Fabricante.Telefonos]
Carpeta=Detalle
Clave=Fabricante.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Detalle.Fabricante.DirInternet]
Carpeta=Detalle
Clave=Fabricante.DirInternet
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33
ColorFondo=Blanco

[Detalle.Fabricante.Notas]
Carpeta=Detalle
Clave=Fabricante.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=33x12
ColorFondo=Blanco

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nuevo
EnBarraAcciones=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
GuardarAntes=
GuardarConfirmar=
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S
Visible=S

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Fabricante
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaAjustarColumnas=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Fabricante.Fabricante
CarpetaVisible=S

[Lista.Fabricante.Fabricante]
Carpeta=Lista
Clave=Fabricante.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Fabricante=183
Nombre=316

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraAcciones=Si
ConfirmarAntes=Si
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=Si
NombreEnBoton=Si
EnBarraHerramientas=Si
Visible=Si

[Acciones.Editar]
Nombre=Editar
Boton=0
Icono=0
NombreDesplegar=&Editar
EnBarraAcciones=Si
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Ir a la Carpeta
Expresion=
SQL=
ListaParametros=Si
VisibleCondicion=FormaNormal
Activo=Si
ActivoCondicion=
EjecucionCondicion=
EjecucionMensaje=
AntesExpresiones=

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Fabricante:Fabricante.Fabricante)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=Si
EspacioPrevio=Si
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Visible=Si
Activo=Si



[Detalle.ListaEnCaptura]
(Inicio)=Fabricante.Fabricante
Fabricante.Fabricante=Fabricante.Telefonos
Fabricante.Telefonos=Fabricante.DirInternet
Fabricante.DirInternet=Fabricante.Notas
Fabricante.Notas=Fabricante.POSAgenteDetalle
Fabricante.POSAgenteDetalle=(Fin)

[Detalle.Fabricante.POSAgenteDetalle]
Carpeta=Detalle
Clave=Fabricante.POSAgenteDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)
