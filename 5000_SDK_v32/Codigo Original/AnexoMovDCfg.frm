[Forma]
Clave=AnexoMovDCfg
Nombre=e(<T>Editar Anexos<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=501
PosicionInicialArriba=198
PosicionInicialAltura=402
PosicionInicialAncho=597
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=426

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoMovD
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
ListaOrden=AnexoMovD.Orden<TAB>(Acendente)
CarpetaVisible=S
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=20
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND ID={Info.ID} AND Cuenta=<T>{Info.Cuenta}<T>

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Detalles
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoMovD
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.Columnas]
Nombre=323
Direccion=321
Tipo=104

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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S
ConfirmarAntes=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Imagen.Anexo.Imagen]
Carpeta=Imagen
Clave=Anexo.Imagen
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Comentario.Anexo.Comentario]
Carpeta=Comentario
Clave=Anexo.Comentario
Editar=S
LineaNueva=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.URL]
Nombre=URL
Boton=57
NombreEnBoton=S
NombreDesplegar=&Examinar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=URL(AnexoMovD:AnexoMovD.Direccion)
ActivoCondicion=AnexoMovD:AnexoMovD.Tipo<><T>Comentario<T>

[Lista.AnexoMovD.Nombre]
Carpeta=Lista
Clave=AnexoMovD.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoMovD.Tipo]
Carpeta=Lista
Clave=AnexoMovD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.Tipo]
Carpeta=Detalle
Clave=AnexoMovD.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.AnexoMovD.Nombre]
Carpeta=Detalle
Clave=AnexoMovD.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.Icono]
Carpeta=Detalle
Clave=AnexoMovD.Icono
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.Direccion]
Carpeta=Detalle
Clave=AnexoMovD.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.Comentario]
Carpeta=Detalle
Clave=AnexoMovD.Comentario
Editar=S
LineaNueva=S
3D=S
Tamano=62x12
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje
Clave=Mensaje
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoMovD
Fuente={Tahoma, 8, Negro, []}
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
CondicionVisible=AnexoMovD:AnexoMovD.Tipo=<T>Mensaje<T>

[Mensaje.AnexoMovD.Fecha]
Carpeta=Mensaje
Clave=AnexoMovD.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoMovD.Origen]
Carpeta=Mensaje
Clave=AnexoMovD.Origen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoMovD.Destino]
Carpeta=Mensaje
Clave=AnexoMovD.Destino
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55x10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.FechaEmision]
Carpeta=Detalle
Clave=AnexoMovD.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.Vencimiento]
Carpeta=Detalle
Clave=AnexoMovD.Vencimiento
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrato]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Contrato
Clave=Contrato
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AnexoCta
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CondicionVisible=AnexoMovD:AnexoMovD.Tipo=<T>Contrato<T>

[Contrato.AnexoCta.TipoDocumento]
Carpeta=Contrato
Clave=AnexoCta.TipoDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.FechaEmision]
Carpeta=Contrato
Clave=AnexoCta.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Inicio]
Carpeta=Contrato
Clave=AnexoCta.Inicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Vencimiento]
Carpeta=Contrato
Clave=AnexoCta.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta.Categoria]
Carpeta=Contrato
Clave=AnexoCta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.Grupo]
Carpeta=Contrato
Clave=AnexoCta.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta.Familia]
Carpeta=Contrato
Clave=AnexoCta.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoMovD.NivelAcceso]
Carpeta=Detalle
Clave=AnexoMovD.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=AnexoMovD.Nombre
AnexoMovD.Nombre=AnexoMovD.Tipo
AnexoMovD.Tipo=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=AnexoMovD.Tipo
AnexoMovD.Tipo=AnexoMovD.Nombre
AnexoMovD.Nombre=AnexoMovD.Icono
AnexoMovD.Icono=AnexoMovD.Direccion
AnexoMovD.Direccion=AnexoMovD.Comentario
AnexoMovD.Comentario=AnexoMovD.FechaEmision
AnexoMovD.FechaEmision=AnexoMovD.Vencimiento
AnexoMovD.Vencimiento=AnexoMovD.NivelAcceso
AnexoMovD.NivelAcceso=(Fin)

[Mensaje.ListaEnCaptura]
(Inicio)=AnexoMovD.Fecha
AnexoMovD.Fecha=AnexoMovD.Origen
AnexoMovD.Origen=AnexoMovD.Destino
AnexoMovD.Destino=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=AnexoCta.TipoDocumento
AnexoCta.TipoDocumento=AnexoCta.FechaEmision
AnexoCta.FechaEmision=AnexoCta.Inicio
AnexoCta.Inicio=AnexoCta.Vencimiento
AnexoCta.Vencimiento=AnexoCta.Categoria
AnexoCta.Categoria=AnexoCta.Grupo
AnexoCta.Grupo=AnexoCta.Familia
AnexoCta.Familia=(Fin)



[Acciones.Archivo]
Nombre=Archivo
Boton=77
NombreEnBoton=S
NombreDesplegar=&Cargar Archivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion













Expresion=FormaModal(<T>AnexoCargarArchivo<T>)<BR>Asigna(AnexoMovD:AnexoMovD.Direccion,Info.Directorio)
ActivoCondicion=AnexoMovD:AnexoMovD.Tipo en (<T>Archivo<T>, <T>Imagen<T>,<T>Contrato<T>)
VisibleCondicion=General.AnexosCloud


[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Mensaje
Mensaje=Contrato
Contrato=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=URL
URL=Archivo
Archivo=Navegador
Navegador=(Fin)
