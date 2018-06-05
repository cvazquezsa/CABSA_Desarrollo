[Forma]
Clave=CteEnviarA
Nombre=<T>Sucursales del Cliente<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=492
PosicionInicialArriba=169
PosicionInicialAltura=564
PosicionInicialAncho=622
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
VentanaExclusiva=S
BarraAyuda=S
PosicionSeccion1=37
ExpresionesAlMostrar=Asigna(Info.Copiar, Falso)
PosicionInicialAlturaCliente=581

PosicionSec1=189
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteEnviarA
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
PestanaOtroNombre=S
PestanaNombre=Lista
HojaMantenerSeleccion=S
Filtros=S
FiltroPredefinido=S
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroAncho=30
OtroOrden=S
ListaOrden=(Lista)
FiltroTodo=S
FiltroGeneral=CteEnviarA.Cliente={Comillas(Info.Cliente)}

[Lista.CteEnviarA.Nombre]
Carpeta=Lista
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CteEnviarA
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

[Detalle.CteEnviarA.Nombre]
Carpeta=Detalle
Clave=CteEnviarA.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.CteEnviarA.Telefonos]
Carpeta=Detalle
Clave=CteEnviarA.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
EspacioPrevio=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Fax]
Carpeta=Detalle
Clave=CteEnviarA.Fax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Contacto1]
Carpeta=Detalle
Clave=CteEnviarA.Contacto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Contacto2]
Carpeta=Detalle
Clave=CteEnviarA.Contacto2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=29
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.eMail1]
Carpeta=Detalle
Clave=CteEnviarA.eMail1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.eMail2]
Carpeta=Detalle
Clave=CteEnviarA.eMail2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=34
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
EnviarA=76
Nombre=244
ID=57
Direccion=263

SATEstado.Descripcion=129
SATMunicipio.Descripcion=123
SATColonia.Descripcion=296
SATCatCP.ClaveCP=104
SATLocalidad.Descripcion=137
[Lista.CteEnviarA.Direccion]
Carpeta=Lista
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=250
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreDesplegar=&Nueva
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Visible=S
Activo=S
GuardarAntes=S
NombreEnBoton=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConfirmarAntes=S
NombreEnBoton=S
ActivoCondicion=no CteEnviarA:CteEnviarA.TieneMovimientos

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Visible=S
Activo=S

[Detalle.CteEnviarA.ID]
Carpeta=Detalle
Clave=CteEnviarA.ID
3D=S
Tamano=10
Efectos=[Negritas]
Editar=S
ColorFuente=Negro
ColorFondo=Blanco
Pegado=S

[Notas.CteEnviarA.Notas]
Carpeta=Notas
Clave=CteEnviarA.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75x17

[Notas.CteEnviarA.Mensaje]
Carpeta=Notas
Clave=CteEnviarA.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=75x3

[Lista.CteEnviarA.ID]
Carpeta=Lista
Clave=CteEnviarA.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Extencion1]
Carpeta=Detalle
Clave=CteEnviarA.Extencion1
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Detalle.CteEnviarA.Extencion2]
Carpeta=Detalle
Clave=CteEnviarA.Extencion2
Editar=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Detalle.CteEnviarA.Observaciones]
Carpeta=Detalle
Clave=CteEnviarA.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Detalle.CteEnviarA.Agente]
Carpeta=Detalle
Clave=CteEnviarA.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.AgenteEnviarA.Nombre]
Carpeta=Detalle
Clave=AgenteEnviarA.Nombre
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Info.Rama, <T>CTE<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, CteEnviarA:CteEnviarA.Cliente+<T>/<T>+CteEnviarA:CteEnviarA.ID)<BR>Asigna(Info.Descripcion, CteEnviarA:CteEnviarA.Nombre)
RefrescarDespues=S

[ReglaNegocio]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Regla Negocio
Clave=ReglaNegocio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CteEnviarA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)

CondicionVisible=Usuario.CteBloquearOtrosDatos=0
[ReglaNegocio.CteEnviarA.Nombre]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Nombre
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
Efectos=[Negritas]

[ReglaNegocio.CteEnviarA.ID]
Carpeta=ReglaNegocio
Clave=CteEnviarA.ID
Editar=N
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
Tamano=20
Efectos=[Negritas]

[ReglaNegocio.CteEnviarA.ListaPreciosEsp]
Carpeta=ReglaNegocio
Clave=CteEnviarA.ListaPreciosEsp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.Proyecto]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Proyecto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.Condicion]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.Descuento]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Descuento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.FormaEnvio]
Carpeta=ReglaNegocio
Clave=CteEnviarA.FormaEnvio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.ZonaImpuesto]
Carpeta=ReglaNegocio
Clave=CteEnviarA.ZonaImpuesto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.CteEnviarA.Estatus]
Carpeta=Detalle
Clave=CteEnviarA.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ReglaNegocio.CteEnviarA.ModificarVencimiento]
Carpeta=ReglaNegocio
Clave=CteEnviarA.ModificarVencimiento
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N
ValidaNombre=S

[Detalle.CteEnviarA.Categoria]
Carpeta=Detalle
Clave=CteEnviarA.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Grupo]
Carpeta=Detalle
Clave=CteEnviarA.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Detalle.CteEnviarA.Familia]
Carpeta=Detalle
Clave=CteEnviarA.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Direccion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Dirección
Clave=Direccion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CteEnviarA
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=95
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Direccion.CteEnviarA.Nombre]
Carpeta=Direccion
Clave=CteEnviarA.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Plata
Efectos=[Negritas]

[Direccion.CteEnviarA.ID]
Carpeta=Direccion
Clave=CteEnviarA.ID
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]

[Direccion.CteEnviarA.Direccion]
Carpeta=Direccion
Clave=CteEnviarA.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=53
ColorFondo=Blanco

[Direccion.CteEnviarA.EntreCalles]
Carpeta=Direccion
Clave=CteEnviarA.EntreCalles
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.CteEnviarA.Plano]
Carpeta=Direccion
Clave=CteEnviarA.Plano
Editar=S
LineaNueva=N
3D=S
Tamano=20
ColorFondo=Blanco
ValidaNombre=S

[Direccion.CteEnviarA.Colonia]
Carpeta=Direccion
Clave=CteEnviarA.Colonia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.CteEnviarA.CodigoPostal]
Carpeta=Direccion
Clave=CteEnviarA.CodigoPostal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Direccion.CteEnviarA.Poblacion]
Carpeta=Direccion
Clave=CteEnviarA.Poblacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Direccion.CteEnviarA.Estado]
Carpeta=Direccion
Clave=CteEnviarA.Estado
Editar=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
LineaNueva=S

[Direccion.CteEnviarA.Pais]
Carpeta=Direccion
Clave=CteEnviarA.Pais
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Direccion.CteEnviarA.Delegacion]
Carpeta=Direccion
Clave=CteEnviarA.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Direccion.CteEnviarA.Observaciones]
Carpeta=Direccion
Clave=CteEnviarA.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Direccion.CteEnviarA.Ruta]
Carpeta=Direccion
Clave=CteEnviarA.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Detalle.CteEnviarA.Contrasena]
Carpeta=Detalle
Clave=CteEnviarA.Contrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.CteEnviarA.Clave]
Carpeta=Detalle
Clave=CteEnviarA.Clave
Editar=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Limite]
Nombre=Limite
Boton=61
NombreDesplegar=Limite Venta
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CteEnviarALimite
ConCondicion=S
Visible=S
Antes=S
DespuesGuardar=S
ActivoCondicion=Config.VentaLimiteNivelSucursal
EjecucionCondicion=ConDatos(CteEnviarA:CteEnviarA.ID)
AntesExpresiones=Asigna(Info.EnviarA, CteEnviarA:CteEnviarA.ID)<BR>Asigna(Info.Descripcion, CteEnviarA:CteEnviarA.Nombre)

[ReglaNegocio.CteEnviarA.SucursalEmpresa]
Carpeta=ReglaNegocio
Clave=CteEnviarA.SucursalEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
EspacioPrevio=N

[ReglaNegocio.Sucursal.Nombre]
Carpeta=ReglaNegocio
Clave=Sucursal.Nombre
Editar=S
3D=S
Tamano=41
ColorFondo=Plata
ValidaNombre=S
OcultaNombre=S

[ReglaNegocio.CteEnviarA.PersonalCobrador]
Carpeta=ReglaNegocio
Clave=CteEnviarA.PersonalCobrador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.PersonalNombre]
Carpeta=ReglaNegocio
Clave=PersonalNombre
Editar=S
ValidaNombre=S
OcultaNombre=S
3D=S
Tamano=41
ColorFondo=Plata

[Acciones.OtrosDatos]
Nombre=OtrosDatos
Boton=38
NombreDesplegar=Otros Datos...
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteEnviarAOtrosDatos
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.ID, CteEnviarA:CteEnviarA.ID)<BR>Asigna(Info.Descripcion, CteEnviarA:CteEnviarA.Nombre)

[ReglaNegocio.CteEnviarA.Almacen]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Almacen
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.AlmacenVtasConsignacion]
Carpeta=ReglaNegocio
Clave=CteEnviarA.AlmacenVtasConsignacion
Editar=S
ValidaNombre=S
3D=S
Tamano=16
ColorFondo=Blanco

[Detalle.CteEnviarA.eMailAuto]
Carpeta=Detalle
Clave=CteEnviarA.eMailAuto
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.CteEnviarA.Zona]
Carpeta=Direccion
Clave=CteEnviarA.Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.wMovVentas]
Carpeta=ReglaNegocio
Clave=CteEnviarA.wMovVentas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[ReglaNegocio.CteEnviarA.Unidad]
Carpeta=ReglaNegocio
Clave=CteEnviarA.Unidad
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S
EspacioPrevio=S

[Detalle.CteEnviarA.Cadena]
Carpeta=Detalle
Clave=CteEnviarA.Cadena
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.CteEnviarAHist]
Nombre=CteEnviarAHist
Boton=53
NombreDesplegar=Histórico de Cambios
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteEnviarAHist
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Cliente, CteEnviarA:CteEnviarA.Cliente)<BR>Asigna(Info.ID, CteEnviarA:CteEnviarA.ID)<BR>Asigna(Info.Nombre, CteEnviarA:CteEnviarA.Nombre)
Visible=S

[Detalle.CteEnviarA.Encargado]
Carpeta=Detalle
Clave=CteEnviarA.Encargado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Direccion.CteEnviarA.DireccionNumero]
Carpeta=Direccion
Clave=CteEnviarA.DireccionNumero
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco

[Direccion.CteEnviarA.GLN]
Carpeta=Direccion
Clave=CteEnviarA.GLN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Direccion.CteEnviarA.DireccionNumeroInt]
Carpeta=Direccion
Clave=CteEnviarA.DireccionNumeroInt
Editar=S
3D=S
Pegado=S
Tamano=6
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=CteEnviarA.ID
CteEnviarA.ID=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Direccion
CteEnviarA.Direccion=(Fin)

[Lista.ListaOrden]
(Inicio)=CteEnviarA.Cliente<TAB>(Acendente)
CteEnviarA.Cliente<TAB>(Acendente)=CteEnviarA.ID<TAB>(Acendente)
CteEnviarA.ID<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.Clave
CteEnviarA.Clave=CteEnviarA.ID
CteEnviarA.ID=CteEnviarA.Categoria
CteEnviarA.Categoria=CteEnviarA.Estatus
CteEnviarA.Estatus=CteEnviarA.Grupo
CteEnviarA.Grupo=CteEnviarA.Familia
CteEnviarA.Familia=CteEnviarA.Encargado
CteEnviarA.Encargado=CteEnviarA.Cadena
CteEnviarA.Cadena=CteEnviarA.Telefonos
CteEnviarA.Telefonos=CteEnviarA.Fax
CteEnviarA.Fax=CteEnviarA.Contacto1
CteEnviarA.Contacto1=CteEnviarA.Extencion1
CteEnviarA.Extencion1=CteEnviarA.Contacto2
CteEnviarA.Contacto2=CteEnviarA.Extencion2
CteEnviarA.Extencion2=CteEnviarA.eMail1
CteEnviarA.eMail1=CteEnviarA.eMail2
CteEnviarA.eMail2=CteEnviarA.eMailAuto
CteEnviarA.eMailAuto=CteEnviarA.Agente
CteEnviarA.Agente=AgenteEnviarA.Nombre
AgenteEnviarA.Nombre=CteEnviarA.Observaciones
CteEnviarA.Observaciones=CteEnviarA.Contrasena
CteEnviarA.Contrasena=(Fin)



[Acciones.Mapa]
Nombre=Mapa
Boton=105
NombreDesplegar=&Mapa
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S











Expresion=Mapa.Borrar<BR>Mapa.Agregar(<T>Cliente|EnviarA<T>, CteEnviarA:CteEnviarA.Cliente+<T>|<T>+CteEnviarA:CteEnviarA.ID)<BR>PlugIn(<T>Mapa<T>, <T>Cliente|EnviarA<T>, <T>Posicionar<T>)
[Fiscal]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Fiscal
Clave=Fiscal
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CteEnviarA
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

CarpetaVisible=S


[Fiscal.CteEnviarA.ID]
Carpeta=Fiscal
Clave=CteEnviarA.ID
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Plata

Tamano=20
[Fiscal.CteEnviarA.FiscalRegimen]
Carpeta=Fiscal
Clave=CteEnviarA.FiscalRegimen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[ReglaNegocio.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.ID
CteEnviarA.ID=CteEnviarA.ListaPreciosEsp
CteEnviarA.ListaPreciosEsp=CteEnviarA.Condicion
CteEnviarA.Condicion=CteEnviarA.Descuento
CteEnviarA.Descuento=CteEnviarA.FormaEnvio
CteEnviarA.FormaEnvio=CteEnviarA.ZonaImpuesto
CteEnviarA.ZonaImpuesto=CteEnviarA.Proyecto
CteEnviarA.Proyecto=CteEnviarA.SucursalEmpresa
CteEnviarA.SucursalEmpresa=Sucursal.Nombre
Sucursal.Nombre=CteEnviarA.Almacen
CteEnviarA.Almacen=CteEnviarA.PersonalCobrador
CteEnviarA.PersonalCobrador=PersonalNombre
PersonalNombre=CteEnviarA.AlmacenVtasConsignacion
CteEnviarA.AlmacenVtasConsignacion=CteEnviarA.Unidad
CteEnviarA.Unidad=CteEnviarA.wMovVentas
CteEnviarA.wMovVentas=CteEnviarA.ModificarVencimiento
CteEnviarA.ModificarVencimiento=(Fin)


[Fiscal.CteEnviarA.Nombre]
Carpeta=Fiscal
Clave=CteEnviarA.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata


















































[Fiscal.CteEnviarA.FiscalZona]
Carpeta=Fiscal
Clave=CteEnviarA.FiscalZona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Acciones.CteEnviarACFD]
Nombre=CteEnviarACFD
Boton=0
NombreEnBoton=S
NombreDesplegar=Datos CFD
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CteEnviarACFD
Activo=S
Visible=N
ActivoCondicion=1=2
EspacioPrevio=S
Antes=S
AntesExpresiones=Asigna(Info.ID, CteEnviarA:CteEnviarA.ID)




[Fiscal.CteEnviarA.TipoProceso]
Carpeta=Fiscal
Clave=CteEnviarA.TipoProceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco

[Fiscal.CteEnviarA.TipoComite]
Carpeta=Fiscal
Clave=CteEnviarA.TipoComite
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[Fiscal.CteEnviarA.IdContabilidad]
Carpeta=Fiscal
Clave=CteEnviarA.IdContabilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.CteEnviarA.ClaveEntidad]
Carpeta=Fiscal
Clave=CteEnviarA.ClaveEntidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Fiscal.CteEnviarA.Ambito]
Carpeta=Fiscal
Clave=CteEnviarA.Ambito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

Pegado=S
[Fiscal.CteEnviarA.EntidadIdContabilidad]
Carpeta=Fiscal
Clave=CteEnviarA.EntidadIdContabilidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco






[Fiscal.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.ID
CteEnviarA.ID=CteEnviarA.FiscalRegimen
CteEnviarA.FiscalRegimen=CteEnviarA.FiscalZona
CteEnviarA.FiscalZona=CteEnviarA.TipoProceso
CteEnviarA.TipoProceso=CteEnviarA.TipoComite
CteEnviarA.TipoComite=CteEnviarA.IdContabilidad
CteEnviarA.IdContabilidad=CteEnviarA.ClaveEntidad
CteEnviarA.ClaveEntidad=CteEnviarA.Ambito
CteEnviarA.Ambito=CteEnviarA.EntidadIdContabilidad
CteEnviarA.EntidadIdContabilidad=(Fin)

















[Forma de Pago]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Forma de Pago
Clave=Forma de Pago
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=CteEnviarA
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

CarpetaVisible=S

[Forma de Pago.CteEnviarA.InstitucionFin]
Carpeta=Forma de Pago
Clave=CteEnviarA.InstitucionFin
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Forma de Pago.CteEnviarA.FormaPago]
Carpeta=Forma de Pago
Clave=CteEnviarA.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Forma de Pago.CteEnviarA.Cuenta]
Carpeta=Forma de Pago
Clave=CteEnviarA.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco







[Forma de Pago.ListaEnCaptura]
(Inicio)=CteEnviarA.InstitucionFin
CteEnviarA.InstitucionFin=CteEnviarA.FormaPago
CteEnviarA.FormaPago=CteEnviarA.Cuenta
CteEnviarA.Cuenta=(Fin)








[Direccion.CteEnviarA.MapaUbicacion]
Carpeta=Direccion
Clave=CteEnviarA.MapaUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco












[Direccion.ListaEnCaptura]
(Inicio)=CteEnviarA.Nombre
CteEnviarA.Nombre=CteEnviarA.ID
CteEnviarA.ID=CteEnviarA.Direccion
CteEnviarA.Direccion=CteEnviarA.DireccionNumero
CteEnviarA.DireccionNumero=CteEnviarA.DireccionNumeroInt
CteEnviarA.DireccionNumeroInt=CteEnviarA.EntreCalles
CteEnviarA.EntreCalles=CteEnviarA.Plano
CteEnviarA.Plano=CteEnviarA.Observaciones
CteEnviarA.Observaciones=CteEnviarA.Delegacion
CteEnviarA.Delegacion=CteEnviarA.Colonia
CteEnviarA.Colonia=CteEnviarA.CodigoPostal
CteEnviarA.CodigoPostal=CteEnviarA.Ruta
CteEnviarA.Ruta=CteEnviarA.Poblacion
CteEnviarA.Poblacion=CteEnviarA.Estado
CteEnviarA.Estado=CteEnviarA.Pais
CteEnviarA.Pais=CteEnviarA.Zona
CteEnviarA.Zona=CteEnviarA.GLN
CteEnviarA.GLN=CteEnviarA.MapaUbicacion
CteEnviarA.MapaUbicacion=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Direccion
Direccion=Fiscal
Fiscal=ReglaNegocio
ReglaNegocio=Forma de Pago
Forma de Pago=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Anexos
Anexos=OtrosDatos
OtrosDatos=CteEnviarAHist
CteEnviarAHist=Limite
Limite=Mapa
Mapa=CteEnviarACFD
CteEnviarACFD=Navegador
Navegador=(Fin)
