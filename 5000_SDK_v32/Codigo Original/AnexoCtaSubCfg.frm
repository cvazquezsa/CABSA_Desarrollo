[Forma]
Clave=AnexoCtaSubCfg
Nombre=e(<T>Editar Anexos<T>)+<T> - <T>+Info.Descripcion + <T> - <T> + Info.SubCuenta
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=530
PosicionInicialArriba=190
PosicionInicialAltura=402
PosicionInicialAncho=539
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
PosicionInicialAlturaCliente=442

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
Vista=AnexoCtaSub
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
ListaOrden=AnexoCtaSub.Orden<TAB>(Acendente)
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

FiltroGeneral=Rama=<T>{Info.Rama}<T> AND Cuenta=<T>{Info.Cuenta}<T> AND SubCuenta = <T>{Info.SubCuenta}<T>
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
Vista=AnexoCtaSub
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

0=52
1=269
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
Expresion=URL(AnexoCtaSub:AnexoCtaSub.Direccion)
ActivoCondicion=AnexoCtaSub:AnexoCtaSub.Tipo<><T>Comentario<T>

[Lista.AnexoCtaSub.Nombre]
Carpeta=Lista
Clave=AnexoCtaSub.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.AnexoCtaSub.Tipo]
Carpeta=Lista
Clave=AnexoCtaSub.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.Tipo]
Carpeta=Detalle
Clave=AnexoCtaSub.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.AnexoCtaSub.Nombre]
Carpeta=Detalle
Clave=AnexoCtaSub.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=37
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.Icono]
Carpeta=Detalle
Clave=AnexoCtaSub.Icono
Editar=S
ValidaNombre=S
3D=S
Pegado=N
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.Direccion]
Carpeta=Detalle
Clave=AnexoCtaSub.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.Comentario]
Carpeta=Detalle
Clave=AnexoCtaSub.Comentario
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

AntesExpresiones=Forma(<T>AnexoCtaSubOrdenar<T>)
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
Vista=AnexoCtaSub
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
CondicionVisible=AnexoCtaSub:AnexoCtaSub.Tipo=<T>Mensaje<T>

[Mensaje.AnexoCtaSub.Fecha]
Carpeta=Mensaje
Clave=AnexoCtaSub.Fecha
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCtaSub.Origen]
Carpeta=Mensaje
Clave=AnexoCtaSub.Origen
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje.AnexoCtaSub.Destino]
Carpeta=Mensaje
Clave=AnexoCtaSub.Destino
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=55x10
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.FechaEmision]
Carpeta=Detalle
Clave=AnexoCtaSub.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.Vencimiento]
Carpeta=Detalle
Clave=AnexoCtaSub.Vencimiento
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
Vista=AnexoCtaSub
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
CondicionVisible=AnexoCtaSub:AnexoCtaSub.Tipo=<T>Contrato<T>

[Contrato.AnexoCtaSub.TipoDocumento]
Carpeta=Contrato
Clave=AnexoCtaSub.TipoDocumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCtaSub.FechaEmision]
Carpeta=Contrato
Clave=AnexoCtaSub.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCtaSub.Inicio]
Carpeta=Contrato
Clave=AnexoCtaSub.Inicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCtaSub.Vencimiento]
Carpeta=Contrato
Clave=AnexoCtaSub.Vencimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Contrato.AnexoCtaSub.Categoria]
Carpeta=Contrato
Clave=AnexoCtaSub.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCtaSub.Grupo]
Carpeta=Contrato
Clave=AnexoCtaSub.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Contrato.AnexoCtaSub.Familia]
Carpeta=Contrato
Clave=AnexoCtaSub.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.AnexoCtaSub.NivelAcceso]
Carpeta=Detalle
Clave=AnexoCtaSub.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro




[Detalle.ListaEnCaptura]
(Inicio)=AnexoCtaSub.Tipo
AnexoCtaSub.Tipo=AnexoCtaSub.Nombre
AnexoCtaSub.Nombre=AnexoCtaSub.Icono
AnexoCtaSub.Icono=AnexoCtaSub.Direccion
AnexoCtaSub.Direccion=AnexoCtaSub.Comentario
AnexoCtaSub.Comentario=AnexoCtaSub.FechaEmision
AnexoCtaSub.FechaEmision=AnexoCtaSub.Vencimiento
AnexoCtaSub.Vencimiento=AnexoCtaSub.NivelAcceso
AnexoCtaSub.NivelAcceso=(Fin)

[Mensaje.ListaEnCaptura]
(Inicio)=AnexoCtaSub.Fecha
AnexoCtaSub.Fecha=AnexoCtaSub.Origen
AnexoCtaSub.Origen=AnexoCtaSub.Destino
AnexoCtaSub.Destino=(Fin)

[Contrato.ListaEnCaptura]
(Inicio)=AnexoCtaSub.TipoDocumento
AnexoCtaSub.TipoDocumento=AnexoCtaSub.FechaEmision
AnexoCtaSub.FechaEmision=AnexoCtaSub.Inicio
AnexoCtaSub.Inicio=AnexoCtaSub.Vencimiento
AnexoCtaSub.Vencimiento=AnexoCtaSub.Categoria
AnexoCtaSub.Categoria=AnexoCtaSub.Grupo
AnexoCtaSub.Grupo=AnexoCtaSub.Familia
AnexoCtaSub.Familia=(Fin)







[Lista.ListaEnCaptura]
(Inicio)=AnexoCtaSub.Nombre
AnexoCtaSub.Nombre=AnexoCtaSub.Tipo
AnexoCtaSub.Tipo=(Fin)













[Acciones.Archivo]
Nombre=Archivo
Boton=77
NombreEnBoton=S
NombreDesplegar=&Cargar archivo
EnBarraHerramientas=S
TipoAccion=Expresion

EspacioPrevio=S














Expresion=FormaModal(<T>AnexoCargarArchivo<T>)<BR>Asigna(AnexoCtaSub:AnexoCtaSub.Direccion,Info.Directorio)
ActivoCondicion=AnexoCtaSub:AnexoCtaSub.Tipo en (<T>Archivo<T>, <T>Imagen<T>,<T>Contrato<T>)
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
