[Forma]
Clave=CfgWeb
Nombre=Configuración Web
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=228
PosicionInicialArriba=172
PosicionInicialAlturaCliente=405
PosicionInicialAncho=568
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgWeb
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

[Ficha.CfgWeb.Empresa]
Carpeta=Ficha
Clave=CfgWeb.Empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Empresa.Nombre]
Carpeta=Ficha
Clave=Empresa.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CfgWeb.Usuario]
Carpeta=Ficha
Clave=CfgWeb.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Usuario.Nombre]
Carpeta=Ficha
Clave=Usuario.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CfgWeb.Almacen]
Carpeta=Ficha
Clave=CfgWeb.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Alm.Nombre]
Carpeta=Ficha
Clave=Alm.Nombre
Editar=S
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.CfgWeb.MovPedido]
Carpeta=Ficha
Clave=CfgWeb.MovPedido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.ActualizarDatosCliente]
Carpeta=Ficha
Clave=CfgWeb.ActualizarDatosCliente
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.PermiteSeleccionarEnviarA]
Carpeta=Ficha
Clave=CfgWeb.PermiteSeleccionarEnviarA
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Confirmación Automática Pedidos
Clave=Confirmacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgWeb
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
CondicionVisible=CfgWeb:CfgWeb.ConfirmacionPedidos

[Confirmacion.CfgWeb.ConfirmacionServidorSMTP]
Carpeta=Confirmacion
Clave=CfgWeb.ConfirmacionServidorSMTP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion.CfgWeb.ConfirmacionNombreRemitente]
Carpeta=Confirmacion
Clave=CfgWeb.ConfirmacionNombreRemitente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion.CfgWeb.ConfirmacionCorreoRemitente]
Carpeta=Confirmacion
Clave=CfgWeb.ConfirmacionCorreoRemitente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion.CfgWeb.ConfirmacionAsunto]
Carpeta=Confirmacion
Clave=CfgWeb.ConfirmacionAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion.CfgWeb.ConfirmacionEnvioInmediato]
Carpeta=Confirmacion
Clave=CfgWeb.ConfirmacionEnvioInmediato
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=60
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

[Ficha.CfgWeb.ConfirmacionPedidos]
Carpeta=Ficha
Clave=CfgWeb.ConfirmacionPedidos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.UEN]
Carpeta=Ficha
Clave=CfgWeb.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.Concepto]
Carpeta=Ficha
Clave=CfgWeb.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.OcultarDescuentoArticulos]
Carpeta=Ficha
Clave=CfgWeb.OcultarDescuentoArticulos
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.CfgWeb.OcultarPrecioLista]
Carpeta=Ficha
Clave=CfgWeb.OcultarPrecioLista
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CfgWeb.MostrarUnicamenteArtExistencia]
Carpeta=Ficha
Clave=CfgWeb.MostrarUnicamenteArtExistencia
Editar=S
LineaNueva=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Confirmacion
Confirmacion=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CfgWeb.Empresa
CfgWeb.Empresa=Empresa.Nombre
Empresa.Nombre=CfgWeb.Usuario
CfgWeb.Usuario=Usuario.Nombre
Usuario.Nombre=CfgWeb.Almacen
CfgWeb.Almacen=Alm.Nombre
Alm.Nombre=CfgWeb.UEN
CfgWeb.UEN=CfgWeb.MovPedido
CfgWeb.MovPedido=CfgWeb.Concepto
CfgWeb.Concepto=CfgWeb.ActualizarDatosCliente
CfgWeb.ActualizarDatosCliente=CfgWeb.PermiteSeleccionarEnviarA
CfgWeb.PermiteSeleccionarEnviarA=CfgWeb.ConfirmacionPedidos
CfgWeb.ConfirmacionPedidos=CfgWeb.OcultarDescuentoArticulos
CfgWeb.OcultarDescuentoArticulos=CfgWeb.OcultarPrecioLista
CfgWeb.OcultarPrecioLista=CfgWeb.MostrarUnicamenteArtExistencia
CfgWeb.MostrarUnicamenteArtExistencia=(Fin)

[Confirmacion.ListaEnCaptura]
(Inicio)=CfgWeb.ConfirmacionServidorSMTP
CfgWeb.ConfirmacionServidorSMTP=CfgWeb.ConfirmacionNombreRemitente
CfgWeb.ConfirmacionNombreRemitente=CfgWeb.ConfirmacionCorreoRemitente
CfgWeb.ConfirmacionCorreoRemitente=CfgWeb.ConfirmacionAsunto
CfgWeb.ConfirmacionAsunto=CfgWeb.ConfirmacionEnvioInmediato
CfgWeb.ConfirmacionEnvioInmediato=(Fin)
