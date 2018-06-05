[Forma]
Clave=AnexoCta50Cfg
Nombre=e(<T>Editar Anexos<T>)+<T> - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=596
PosicionInicialArriba=342
PosicionInicialAltura=402
PosicionInicialAncho=407
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=138

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
Vista=AnexoCta50
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
ListaOrden=AnexoCta50.Orden<TAB>(Acendente)
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
FiltroGeneral=Rama=<T>{Info.Rama}<T> AND Cuenta=<T>{Info.Cuenta}<T>

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
Vista=AnexoCta50
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
Nombre=319
Direccion=321
Tipo=106

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
Expresion=URL(AnexoCta50:AnexoCta50.Direccion)
ActivoCondicion=AnexoCta50:AnexoCta50.Tipo<><T>Comentario<T>

[Lista.AnexoCta50.Nombre]
Carpeta=Lista
Clave=AnexoCta50.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoCta50.Tipo]
Carpeta=Lista
Clave=AnexoCta50.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.Tipo]
Carpeta=Detalle
Clave=AnexoCta50.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.AnexoCta50.Nombre]
Carpeta=Detalle
Clave=AnexoCta50.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.Icono]
Carpeta=Detalle
Clave=AnexoCta50.Icono
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.Direccion]
Carpeta=Detalle
Clave=AnexoCta50.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.Comentario]
Carpeta=Detalle
Clave=AnexoCta50.Comentario
Editar=S
LineaNueva=S
3D=S
Tamano=62x12
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>AnexoCta50Ordenar<T>)

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
Vista=AnexoCta50
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
CondicionVisible=AnexoCta50:AnexoCta50.Tipo=<T>Mensaje<T>

[Mensaje.AnexoCta50.Fecha]
Carpeta=Mensaje
Clave=AnexoCta50.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCta50.Origen]
Carpeta=Mensaje
Clave=AnexoCta50.Origen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCta50.Destino]
Carpeta=Mensaje
Clave=AnexoCta50.Destino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55x10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.FechaEmision]
Carpeta=Detalle
Clave=AnexoCta50.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.Vencimiento]
Carpeta=Detalle
Clave=AnexoCta50.Vencimiento
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
Vista=AnexoCta50
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
CondicionVisible=AnexoCta50:AnexoCta50.Tipo=<T>Contrato<T>

[Contrato.AnexoCta50.TipoDocumento]
Carpeta=Contrato
Clave=AnexoCta50.TipoDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta50.FechaEmision]
Carpeta=Contrato
Clave=AnexoCta50.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta50.Inicio]
Carpeta=Contrato
Clave=AnexoCta50.Inicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta50.Vencimiento]
Carpeta=Contrato
Clave=AnexoCta50.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCta50.Categoria]
Carpeta=Contrato
Clave=AnexoCta50.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta50.Grupo]
Carpeta=Contrato
Clave=AnexoCta50.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCta50.Familia]
Carpeta=Contrato
Clave=AnexoCta50.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCta50.NivelAcceso]
Carpeta=Detalle
Clave=AnexoCta50.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro



[Lista.ListaEnCaptura]
(Inicio)=AnexoCta50.Nombre
AnexoCta50.Nombre=AnexoCta50.Tipo
AnexoCta50.Tipo=(Fin)


[Mensaje.ListaEnCaptura]
(Inicio)=AnexoCta50.Fecha
AnexoCta50.Fecha=AnexoCta50.Origen
AnexoCta50.Origen=AnexoCta50.Destino
AnexoCta50.Destino=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=AnexoCta50.TipoDocumento
AnexoCta50.TipoDocumento=AnexoCta50.FechaEmision
AnexoCta50.FechaEmision=AnexoCta50.Inicio
AnexoCta50.Inicio=AnexoCta50.Vencimiento
AnexoCta50.Vencimiento=AnexoCta50.Categoria
AnexoCta50.Categoria=AnexoCta50.Grupo
AnexoCta50.Grupo=AnexoCta50.Familia
AnexoCta50.Familia=(Fin)


[Detalle.AnexoCta50.Direccion2]
Carpeta=Detalle
Clave=AnexoCta50.Direccion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro
















[Detalle.AnexoCta50.Direccion3]
Carpeta=Detalle
Clave=AnexoCta50.Direccion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro













[Detalle.ListaEnCaptura]
(Inicio)=AnexoCta50.Tipo
AnexoCta50.Tipo=AnexoCta50.Nombre
AnexoCta50.Nombre=AnexoCta50.Icono
AnexoCta50.Icono=AnexoCta50.Direccion
AnexoCta50.Direccion=AnexoCta50.Direccion2
AnexoCta50.Direccion2=AnexoCta50.Direccion3
AnexoCta50.Direccion3=AnexoCta50.Comentario
AnexoCta50.Comentario=AnexoCta50.FechaEmision
AnexoCta50.FechaEmision=AnexoCta50.Vencimiento
AnexoCta50.Vencimiento=AnexoCta50.NivelAcceso
AnexoCta50.NivelAcceso=(Fin)









[Acciones.Archivo]
Nombre=Archivo
Boton=77
NombreDesplegar=&Cargar Archivo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion





NombreEnBoton=S


















Expresion=CASO AnexoCta50:AnexoCta50.Tipo<BR> Es <T>Imagen<T> Entonces FormaModal(<T>AnexoCtaCargarArchivo<T>)<BR>Sino<BR>  FormaModal(<T>AnexoCargarArchivo<T>) <BR>Fin<BR>Asigna(AnexoCta50:AnexoCta50.Direccion,Info.Directorio)<BR>Asigna(AnexoCta50:AnexoCta50.Direccion2,Info.Clase2)<BR>Asigna(AnexoCta50:AnexoCta50.Direccion3,Info.Clase3)
ActivoCondicion=AnexoCta50:AnexoCta50.Tipo en (<T>Archivo<T>, <T>Imagen<T>,<T>Contrato<T>)
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
URL=Ordenar
Ordenar=Archivo
Archivo=Navegador
Navegador=(Fin)
